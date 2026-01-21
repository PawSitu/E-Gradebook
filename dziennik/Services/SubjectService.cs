using dziennik.Models;
using System;
using System.Collections.Generic;
using System.Data.SQLite;
using System.Threading.Tasks;

namespace dziennik.Services
{
    public class SubjectService : DatabaseService
    {

        public async Task<List<Subject>> GetAllSubjects()
        {
            var subjects = new List<Subject>();

            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand("SELECT Id, Nazwa FROM Przedmiot", connection);

                using var reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                {
                    subjects.Add(new Subject
                    {
                        Id = Convert.ToInt32(reader["Id"]),
                        Name = reader["Nazwa"].ToString()
                    });
                }
            });

            return subjects;
        }

        public async Task<List<Subject>> GetTeacherSubjects(int teacherId)
        {
            var subjects = new List<Subject>();

            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand(
                    @"SELECT DISTINCT p.Id, p.Nazwa
                    FROM Przedmiot p
                    JOIN Zajecia z ON p.Id = z.PrzedmiotId
                    WHERE z.NauczycielId = @NauczycielId", connection);
                sqlCommand.Parameters.AddWithValue("@NauczycielId", teacherId);

                using var reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                {
                    subjects.Add(new Subject
                    {
                        Id = Convert.ToInt32(reader["Id"]),
                        Name = reader["Nazwa"].ToString()
                    });
                }
            });

            return subjects;
        }

        public async Task<int> GetLessonIdForTeacherAndSubject(int teacherId, int subjectId)
        {
            int lessonId = 0;

            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand(
                    @"SELECT Id FROM Zajecia 
                    WHERE NauczycielId = @NauczycielId 
                    AND PrzedmiotId = @PrzedmiotId", connection);
                sqlCommand.Parameters.AddWithValue("@NauczycielId", teacherId);
                sqlCommand.Parameters.AddWithValue("@PrzedmiotId", subjectId);

                var result = sqlCommand.ExecuteScalar();
                if (result != null && result != DBNull.Value)
                {
                    lessonId = Convert.ToInt32(result);
                }
                else
                {
                    var addSQL = new SQLiteCommand(
                        @"INSERT INTO Zajecia (NauczycielId, PrzedmiotId)
                        VALUES (@NauczycielId, @PrzedmiotId);
                        SELECT last_insert_rowid();", connection);
                    addSQL.Parameters.AddWithValue("@NauczycielId", teacherId);
                    addSQL.Parameters.AddWithValue("@PrzedmiotId", subjectId);

                    lessonId = Convert.ToInt32(addSQL.ExecuteScalar());
                }
            });

            return lessonId;
        }

        public async Task<int> AddSubject(Subject subject)
        {
            int subjectId = 0;

            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand(
                    @"INSERT INTO Przedmiot (Nazwa)
                    VALUES (@Nazwa);
                    SELECT last_insert_rowid();", connection);
                sqlCommand.Parameters.AddWithValue("@Nazwa", subject.Name);

                subjectId = Convert.ToInt32(sqlCommand.ExecuteScalar());
            });

            return subjectId;
        }

        public async Task UpdateSubject(Subject subject)
        {
            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand(
                    @"UPDATE Przedmiot
                    SET Nazwa = @Nazwa
                    WHERE Id = @Id", connection);
                sqlCommand.Parameters.AddWithValue("@Nazwa", subject.Name);
                sqlCommand.Parameters.AddWithValue("@Id", subject.Id);

                sqlCommand.ExecuteNonQuery();
            });
        }

        public async Task DeleteSubject(int subjectId)
        {
            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();
                using var transaction = connection.BeginTransaction();

                try
                {
                    var deleteLessons = new SQLiteCommand(
                        @"DELETE FROM Zajecia WHERE PrzedmiotId = @PrzedmiotId", connection, transaction);
                    deleteLessons.Parameters.AddWithValue("@PrzedmiotId", subjectId);
                    deleteLessons.ExecuteNonQuery();

                    var deleteSubject = new SQLiteCommand(
                        @"DELETE FROM Przedmiot WHERE Id = @Id", connection, transaction);
                    deleteSubject.Parameters.AddWithValue("@Id", subjectId);
                    deleteSubject.ExecuteNonQuery();

                    transaction.Commit();
                }
                catch (Exception)
                {
                    transaction.Rollback();
                    throw;
                }
            });
        }

        public async Task<List<Subject>> GetStudentSubjects(int studentId)
        {
            var subjects = new List<Subject>();

            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand(
                    @"SELECT DISTINCT p.Id, p.Nazwa
                    FROM Przedmiot p
                    JOIN Zajecia z ON p.Id = z.PrzedmiotId
                    JOIN PlanZajec pz ON z.Id = pz.ZajeciaId
                    JOIN Uczen u ON pz.KlasaId = u.KlasaId
                    WHERE u.Id = @UczenId", connection);
                sqlCommand.Parameters.AddWithValue("@UczenId", studentId);

                using var reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                {
                    subjects.Add(new Subject
                    {
                        Id = Convert.ToInt32(reader["Id"]),
                        Name = reader["Nazwa"].ToString()
                    });
                }
            });

            return subjects;
        }
    }
}

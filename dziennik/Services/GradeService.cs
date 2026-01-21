using dziennik.Models;
using System.Data.SQLite;

namespace dziennik.Services
{
    public class GradeService : DatabaseService
    {
        public async Task<List<Grade>> GetStudentGrades(int studentId) 
        {
            var grades = new List<Grade>();

            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand(
                    @"SELECT o.Id, o.Wartosc, o.DataWystawienia, o.UczenId, o.ZajeciaId,
                    p.Id as PrzedmiotId, p.Nazwa as PrzedmiotNazwa,
                    n.Id as NauczycielId, 
                    os.Imie as NauczycielImie, os.Nazwisko as NauczycielNazwisko
                    FROM Ocena o
                    JOIN Zajecia z ON o.ZajeciaId = z.Id
                    JOIN Przedmiot p ON z.PrzedmiotId = p.Id
                    JOIN Nauczyciel n ON z.NauczycielId = n.Id
                    JOIN Osoba os ON n.OsobaId = os.Id
                    WHERE o.UczenId = @UczenId", connection);
                sqlCommand.Parameters.AddWithValue("@UczenId", studentId);

                using var reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                {
                    grades.Add(new Grade
                    {
                        Id = Convert.ToInt32(reader["Id"]),
                        Value = Convert.ToDouble(reader["Wartosc"]),
                        IssueDate = Convert.ToDateTime(reader["DataWystawienia"]),
                        StudentId = Convert.ToInt32(reader["UczenId"]),
                        LessonId = Convert.ToInt32(reader["ZajeciaId"]),
                        Lesson = new Lesson
                        {
                            Id = Convert.ToInt32(reader["ZajeciaId"]),
                            TeacherId = Convert.ToInt32(reader["NauczycielId"]),
                            SubjectId = Convert.ToInt32(reader["PrzedmiotId"]),
                            Subject = new Subject
                            {
                                Id = Convert.ToInt32(reader["PrzedmiotId"]),
                                Name = reader["PrzedmiotNazwa"].ToString()
                            },
                            Teacher = new Teacher
                            {
                                Id = Convert.ToInt32(reader["NauczycielId"]),
                                Person = new Person
                                {
                                    FirstName = reader["NauczycielImie"].ToString(),
                                    LastName = reader["NauczycielNazwisko"].ToString()
                                }
                            }
                        }
                    });
                }
            });

            return grades;
        }

        public async Task AddGrade(Grade grade)
        {
            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand(
                    @"INSERT INTO Ocena (Wartosc, DataWystawienia, UczenId, ZajeciaId) 
                    VALUES (@Wartosc, @DataWystawienia, @UczenId, @ZajeciaId)", connection);
                sqlCommand.Parameters.AddWithValue("@Wartosc", grade.Value);
                sqlCommand.Parameters.AddWithValue("@DataWystawienia", grade.IssueDate);
                sqlCommand.Parameters.AddWithValue("@UczenId", grade.StudentId);
                sqlCommand.Parameters.AddWithValue("@ZajeciaId", grade.LessonId);

                sqlCommand.ExecuteNonQuery();
            });
        }

        public async Task DeleteGrade(int gradeId)
        {
            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand("DELETE FROM Ocena WHERE Id = @Id", connection);
                sqlCommand.Parameters.AddWithValue("@Id", gradeId);

                sqlCommand.ExecuteNonQuery();
            });
        }
        public async Task<List<Grade>> GetStudentGradesBySubject(int studentId, int subjectId)
        {
            var grades = new List<Grade>();

            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand(
                    @"SELECT o.Id, o.Wartosc, o.DataWystawienia, o.UczenId, o.ZajeciaId,
                    p.Id as PrzedmiotId, p.Nazwa as PrzedmiotNazwa,
                    n.Id as NauczycielId, 
                    os.Imie as NauczycielImie, os.Nazwisko as NauczycielNazwisko
                    FROM Ocena o
                    JOIN Zajecia z ON o.ZajeciaId = z.Id
                    JOIN Przedmiot p ON z.PrzedmiotId = p.Id
                    JOIN Nauczyciel n ON z.NauczycielId = n.Id
                    JOIN Osoba os ON n.OsobaId = os.Id
                    WHERE o.UczenId = @UczenId AND p.Id = @PrzedmiotId", connection);
                sqlCommand.Parameters.AddWithValue("@UczenId", studentId);
                sqlCommand.Parameters.AddWithValue("@PrzedmiotId", subjectId);

                using var reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                {
                    grades.Add(new Grade
                    {
                        Id = Convert.ToInt32(reader["Id"]),
                        Value = Convert.ToDouble(reader["Wartosc"]),
                        IssueDate = Convert.ToDateTime(reader["DataWystawienia"]),
                        StudentId = Convert.ToInt32(reader["UczenId"]),
                        LessonId = Convert.ToInt32(reader["ZajeciaId"]),
                        Lesson = new Lesson
                        {
                            Id = Convert.ToInt32(reader["ZajeciaId"]),
                            TeacherId = Convert.ToInt32(reader["NauczycielId"]),
                            SubjectId = Convert.ToInt32(reader["PrzedmiotId"]),
                            Subject = new Subject
                            {
                                Id = Convert.ToInt32(reader["PrzedmiotId"]),
                                Name = reader["PrzedmiotNazwa"].ToString()
                            },
                            Teacher = new Teacher
                            {
                                Id = Convert.ToInt32(reader["NauczycielId"]),
                                Person = new Person
                                {
                                    FirstName = reader["NauczycielImie"].ToString(),
                                    LastName = reader["NauczycielNazwisko"].ToString()
                                }
                            }
                        }
                    });
                }
            });

            return grades;
        }
        public async Task UpdateGrade(Grade grade)
        {
            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand(
                    @"UPDATE Ocena 
                    SET Wartosc = @Wartosc
                    WHERE Id = @Id", connection);
                sqlCommand.Parameters.AddWithValue("@Wartosc", grade.Value);
                sqlCommand.Parameters.AddWithValue("@Id", grade.Id);

                sqlCommand.ExecuteNonQuery();
            });
        }
    }
}
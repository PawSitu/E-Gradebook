using dziennik.Models;
using System.Data.SQLite;

namespace dziennik.Services
{
    public class ClassService : DatabaseService
    {
        public async Task<List<Student>> GetClassStudents(int classId)
        {
            var students = new List<Student>();

            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand(
                    @"SELECT u.Id, u.OsobaId, u.KlasaId, 
                    o.Imie, o.Nazwisko
                    FROM Uczen u
                    JOIN Osoba o ON u.OsobaId = o.Id
                    WHERE u.KlasaId = @KlasaId
                    ORDER BY o.Nazwisko, o.Imie", connection);
                sqlCommand.Parameters.AddWithValue("@KlasaId", classId);

                using var reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                {
                    students.Add(new Student
                    {
                        Id = Convert.ToInt32(reader["Id"]),
                        PersonId = Convert.ToInt32(reader["OsobaId"]),
                        ClassId = Convert.ToInt32(reader["KlasaId"]),
                        Person = new Person
                        {
                            Id = Convert.ToInt32(reader["OsobaId"]),
                            FirstName = reader["Imie"].ToString(),
                            LastName = reader["Nazwisko"].ToString()
                        }
                    });
                }
            });

            return students;
        }
    }
}
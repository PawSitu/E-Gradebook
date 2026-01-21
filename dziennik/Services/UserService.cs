using dziennik.Models;
using System;
using System.Data.SQLite;

namespace dziennik.Services
{
    public class UserService : DatabaseService, IUserService
    {
        public class LoginResult
        {
            public bool IsSuccessful { get; set; } 
            public string Message { get; set; } 
            public Person Person { get; set; }  
            public Student Student { get; set; }
            public Teacher Teacher { get; set; } 
            public Admin Admin { get; set; }
        }

        public LoginResult LoginUser(string login, string password) 
        {
            using var connection = ConnectDatabase();
            connection.Open();

            var personSQL = new SQLiteCommand(
                "SELECT * FROM Osoba WHERE Login = @Login AND Haslo = @Haslo", connection);
            personSQL.Parameters.AddWithValue("@Login", login);
            personSQL.Parameters.AddWithValue("@Haslo", password);

            using var reader = personSQL.ExecuteReader();
            if (!reader.Read())
            {
                return new LoginResult 
                {
                    IsSuccessful = false,
                    Message = "Nieprawidłowy login lub hasło."
                };
            }

            var person = new Person
            {
                Id = Convert.ToInt32(reader["Id"]),
                FirstName = reader["Imie"].ToString(),
                LastName = reader["Nazwisko"].ToString(),
                Login = reader["Login"].ToString(),
                Password = reader["Haslo"].ToString()
            };
            reader.Close();

            /*var adminSQL = new SQLiteCommand(
                "SELECT * FROM Admin WHERE OsobaId = @OsobaId", connection);
            adminSQL.Parameters.AddWithValue("@OsobaId", person.Id);

            using var adminReader = adminSQL.ExecuteReader();
            if (adminReader.Read())
            {
                var admin = new Admin
                {
                    Id = Convert.ToInt32(adminReader["Id"]),
                    PersonId = person.Id,
                    Person = person
                };
                return new LoginResult
                {
                    IsSuccessful = true,
                    Person = person,
                    Admin = admin
                };
            }
            adminReader.Close();*/

            var teacherSQL = new SQLiteCommand(
                "SELECT * FROM Nauczyciel WHERE OsobaId = @OsobaId", connection);
            teacherSQL.Parameters.AddWithValue("@OsobaId", person.Id);

            using var teacherReader = teacherSQL.ExecuteReader();
            if (teacherReader.Read())
            {
                var teacher = new Teacher
                {
                    Id = Convert.ToInt32(teacherReader["Id"]),
                    PersonId = person.Id,
                    Person = person
                };

                return new LoginResult
                {
                    IsSuccessful = true,
                    Person = person,
                    Teacher = teacher
                };
            }
            teacherReader.Close();

            var studentSQL = new SQLiteCommand(
                "SELECT * FROM Uczen WHERE OsobaId = @OsobaId", connection);
            studentSQL.Parameters.AddWithValue("@OsobaId", person.Id);

            using var studentReader = studentSQL.ExecuteReader();
            if (studentReader.Read())
            {
                var student = new Student
                {
                    Id = Convert.ToInt32(studentReader["Id"]),
                    PersonId = person.Id,
                    ClassId = Convert.ToInt32(studentReader["KlasaId"]),
                    Person = person
                };

                studentReader.Close();
                var classSQL = new SQLiteCommand(
                    "SELECT * FROM Klasa WHERE Id = @KlasaId", connection);
                classSQL.Parameters.AddWithValue("@KlasaId", student.ClassId);

                using var classReader = classSQL.ExecuteReader();
                if (classReader.Read())
                {
                    student.Class = new Class
                    {
                        Id = Convert.ToInt32(classReader["Id"]),
                        Name = classReader["Nazwa"].ToString()
                    };
                }

                return new LoginResult
                {
                    IsSuccessful = true,
                    Person = person,
                    Student = student
                };
            }

            return new LoginResult 
            {
                IsSuccessful = false,
                Message = "Nie znaleziono użytkownika w systemie."
            };
        }
    }
}
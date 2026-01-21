using dziennik.Models;
using System;
using System.Collections.Generic;
using System.Data.SQLite;
using System.Threading.Tasks;

namespace dziennik.Services
{
    public class ScheduleService : DatabaseService
    {
        public async Task<List<Schedule>> GetClassSchedule(int classId)
        {
            var schedule = new List<Schedule>();

            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand(
                    @"SELECT pz.Id, pz.KlasaId, pz.ZajeciaId, pz.DzienTygodnia, pz.Godzina,
                    z.NauczycielId, z.PrzedmiotId, p.Nazwa AS PrzedmiotNazwa, k.Nazwa AS KlasaNazwa,
                    n.OsobaId AS NauczycielOsobaId, o.Imie AS NauczycielImie, o.Nazwisko AS NauczycielNazwisko
                    FROM PlanZajec pz
                    JOIN Zajecia z ON pz.ZajeciaId = z.Id
                    JOIN Przedmiot p ON z.PrzedmiotId = p.Id
                    JOIN Klasa k ON pz.KlasaId = k.Id
                    JOIN Nauczyciel n ON z.NauczycielId = n.Id
                    JOIN Osoba o ON n.OsobaId = o.Id
                    WHERE pz.KlasaId = @KlasaId", connection);
                sqlCommand.Parameters.AddWithValue("@KlasaId", classId);

                using var reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                {
                    schedule.Add(new Schedule
                    {
                        Id = Convert.ToInt32(reader["Id"]),
                        ClassId = Convert.ToInt32(reader["KlasaId"]),
                        LessonId = Convert.ToInt32(reader["ZajeciaId"]),
                        DayOfWeek = reader["DzienTygodnia"].ToString(),
                        Time = reader["Godzina"].ToString(),
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
                                PersonId = Convert.ToInt32(reader["NauczycielOsobaId"]),
                                Person = new Person
                                {
                                    Id = Convert.ToInt32(reader["NauczycielOsobaId"]),
                                    FirstName = reader["NauczycielImie"].ToString(),
                                    LastName = reader["NauczycielNazwisko"].ToString()
                                }
                            }
                        },
                        Class = new Class
                        {
                            Id = Convert.ToInt32(reader["KlasaId"]),
                            Name = reader["KlasaNazwa"].ToString()
                        }
                    });
                }
            });

            return schedule;
        }

        public async Task<List<Schedule>> GetTeacherSchedule(int teacherId)
        {
            var schedule = new List<Schedule>();

            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand(
                    @"SELECT pz.Id, pz.KlasaId, pz.ZajeciaId, pz.DzienTygodnia, pz.Godzina,
                    z.NauczycielId, z.PrzedmiotId, p.Nazwa AS PrzedmiotNazwa, k.Nazwa AS KlasaNazwa,
                    n.OsobaId AS NauczycielOsobaId, o.Imie AS NauczycielImie, o.Nazwisko AS NauczycielNazwisko
                    FROM PlanZajec pz
                    JOIN Zajecia z ON pz.ZajeciaId = z.Id
                    JOIN Przedmiot p ON z.PrzedmiotId = p.Id
                    JOIN Klasa k ON pz.KlasaId = k.Id
                    JOIN Nauczyciel n ON z.NauczycielId = n.Id
                    JOIN Osoba o ON n.OsobaId = o.Id
                    WHERE z.NauczycielId = @NauczycielId", connection);
                sqlCommand.Parameters.AddWithValue("@NauczycielId", teacherId);

                using var reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                {
                    schedule.Add(new Schedule
                    {
                        Id = Convert.ToInt32(reader["Id"]),
                        ClassId = Convert.ToInt32(reader["KlasaId"]),
                        LessonId = Convert.ToInt32(reader["ZajeciaId"]),
                        DayOfWeek = reader["DzienTygodnia"].ToString(),
                        Time = reader["Godzina"].ToString(),
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
                                PersonId = Convert.ToInt32(reader["NauczycielOsobaId"]),
                                Person = new Person
                                {
                                    Id = Convert.ToInt32(reader["NauczycielOsobaId"]),
                                    FirstName = reader["NauczycielImie"].ToString(),
                                    LastName = reader["NauczycielNazwisko"].ToString()
                                }
                            }
                        },
                        Class = new Class
                        {
                            Id = Convert.ToInt32(reader["KlasaId"]),
                            Name = reader["KlasaNazwa"].ToString()
                        }
                    });
                }
            });

            return schedule;
        }
        public async Task<bool> DoesTeacherTeachClass(int teacherId, int classId)
        {
            bool teaches = false;

            await Task.Run(() =>
            {
                using var connection = ConnectDatabase();
                connection.Open();

                var sqlCommand = new SQLiteCommand(
                    @"SELECT COUNT(*) FROM PlanZajec pz
                    JOIN Zajecia z ON pz.ZajeciaId = z.Id
                    WHERE z.NauczycielId = @NauczycielId AND pz.KlasaId = @KlasaId", connection);
                sqlCommand.Parameters.AddWithValue("@NauczycielId", teacherId);
                sqlCommand.Parameters.AddWithValue("@KlasaId", classId);

                var result = sqlCommand.ExecuteScalar();
                teaches = Convert.ToInt32(result) > 0;
            });

            return teaches;
        }

       
    }
}

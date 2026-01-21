namespace dziennik.Models
{
    public class Attendance
    {
        public int Id { get; set; }
        public int StudentId { get; set; }
        public int LessonId { get; set; }
        public DateTime Date { get; set; }
        public int Status { get; set; }

        public Student Student { get; set; }
        public Lesson Lesson { get; set; }
    }
}
namespace dziennik.Models
{
    public class Grade
    {
        public int Id { get; set; }
        public double Value { get; set; }
        public DateTime IssueDate { get; set; }
        public int StudentId { get; set; }
        public int LessonId { get; set; }

        public Student Student { get; set; }
        public Lesson Lesson { get; set; }
    }
}

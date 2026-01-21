using dziennik.Models;
using dziennik.Services;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Data;
using System.Windows.Input;

namespace dziennik.ViewModels
{
    public class StudentViewModel : BaseViewModel
    {
        private readonly MainViewModel _mainViewModel;
        private readonly GradeService _gradeService = new GradeService();
        private readonly AttendanceService _attendanceService = new AttendanceService();
        private readonly ScheduleService _scheduleService = new ScheduleService();

        private Student _student;
        private ObservableCollection<SubjectGrades> _subjectsGrades = new ObservableCollection<SubjectGrades>();
        private ObservableCollection<AttendanceLesson> _attendance = new ObservableCollection<AttendanceLesson>();
        private ObservableCollection<ScheduleLessonItem> _schedule = new ObservableCollection<ScheduleLessonItem>();
        private ObservableCollection<SubjectAttendance> _subjectsAttendance = new ObservableCollection<SubjectAttendance>();

        private double _overallAverage;
        private double _overallAttendance;
        public Student Student => _student;

        public string FullName => $"{_student.Person.FirstName} {_student.Person.LastName}";

        public string ClassName => _student.Class?.Name ?? "No class assigned";

        public StudentViewModel(Student student, MainViewModel mainViewModel)
        {
            _student = student;
            _mainViewModel = mainViewModel;
            LogoutCommand = new RelayCommand(Logout);

            LoadStudentData();
        }

        #region Methods
        private async void LoadStudentData()
        {
            try
            {
                var grades = await _gradeService.GetStudentGrades(_student.Id);
                var subjects = grades.GroupBy(g => g.Lesson.Subject.Id)
                    .Select(g => {
                        double subjectAverage = Math.Round(g.Average(o => o.Value), 2);
                        int finalGrade = (int)Math.Round(subjectAverage);

                        return new SubjectGrades
                        {
                            Subject = g.First().Lesson.Subject,
                            Grades = new ObservableCollection<Grade>(g.ToList()),
                            SubjectAverage = subjectAverage,
                            FinalGrade = finalGrade
                        };
                    })
                    .ToList();

                SubjectsGrades = new ObservableCollection<SubjectGrades>(subjects);

                OverallAverage = Math.Round(subjects.Average(p => p.FinalGrade), 2);

                var attendance = await _attendanceService.GetStudentAttendances(_student.Id);
                Attendance = new ObservableCollection<AttendanceLesson>(attendance);

                await CalculateSubjectAttendances();

                CalculateOverallAttendance();

                var schedule = await LoadSchedule();
                Schedule = new ObservableCollection<ScheduleLessonItem>(schedule);

                var scheduleView = CollectionViewSource.GetDefaultView(Schedule);
                scheduleView.GroupDescriptions.Add(new PropertyGroupDescription("DayName"));
                scheduleView.SortDescriptions.Add(new SortDescription("DayOfWeekNumber", ListSortDirection.Ascending));
                scheduleView.SortDescriptions.Add(new SortDescription("StartTime", ListSortDirection.Ascending));
            }
            catch (Exception ex)
            {
            }
        }

        private async Task CalculateSubjectAttendances()
        {
            var subjectsList = new List<SubjectAttendance>();

            var subjectsMap = Attendance
                .GroupBy(f => f.Subject)
                .ToDictionary(g => g.Key, g => g.ToList());

            foreach (var entry in subjectsMap)
            {
                string subjectName = entry.Key;
                var attendancesList = entry.Value;

                int total = attendancesList.Count;
                int present = attendancesList.Count(f => f.Status == "Present");
                int late = attendancesList.Count(f => f.Status == "Late");

                double attendancePercent = total > 0
                    ? Math.Round(100.0 * (present + late) / total, 2)
                    : 0;

                subjectsList.Add(new SubjectAttendance
                {
                    SubjectName = subjectName,
                    AttendancePercent = attendancePercent,
                    PresentCount = present,
                    LateCount = late,
                    TotalCount = total
                });
            }

            SubjectsAttendance = new ObservableCollection<SubjectAttendance>(
                subjectsList.OrderBy(p => p.SubjectName));
        }

        private void CalculateOverallAttendance()
        {
            int totalOverall = Attendance.Count;
            int presentOverall = Attendance.Count(f => f.Status == "Present");
            int lateOverall = Attendance.Count(f => f.Status == "Late");

            OverallAttendance = totalOverall > 0
                ? Math.Round(100.0 * (presentOverall + lateOverall) / totalOverall, 2)
                : 0;
        }

        private async Task<List<ScheduleLessonItem>> LoadSchedule()
        {
            var scheduleLessons = new List<ScheduleLessonItem>();

            var schedule = await _scheduleService.GetClassSchedule(_student.ClassId);

            foreach (var lesson in schedule)
            {
                DateTime startTime = DateTime.Parse(lesson.Time);
                DateTime endTime = startTime.AddMinutes(90);

                int dayOfWeekNumber = lesson.DayOfWeek switch 
                {
                    "Poniedzialek" => 0,
                    "Wtorek" => 1,
                    "Sroda" => 2,
                    "Czwartek" => 3,
                    "Piatek" => 4,
                    _ => 6
                };

                var scheduleLessonItem = new ScheduleLessonItem
                {
                    StartTime = startTime,
                    EndTime = endTime,
                    SubjectName = lesson.Lesson.Subject.Name,
                    TeacherLastName = $"{lesson.Lesson.Teacher?.Person?.FirstName} {lesson.Lesson.Teacher?.Person?.LastName}",
                    DayOfWeek = lesson.DayOfWeek,
                    DayOfWeekNumber = dayOfWeekNumber
                };

                scheduleLessons.Add(scheduleLessonItem);
            }

            return scheduleLessons;
        }
        private void Logout()
        {
            _mainViewModel.Logout();
        }
        #endregion

        #region Getters/Setters
        public ObservableCollection<SubjectGrades> SubjectsGrades
        {
            get => _subjectsGrades;
            set => SetProperty(ref _subjectsGrades, value);
        }

        public ObservableCollection<AttendanceLesson> Attendance
        {
            get => _attendance;
            set => SetProperty(ref _attendance, value);
        }

        public ObservableCollection<SubjectAttendance> SubjectsAttendance
        {
            get => _subjectsAttendance;
            set => SetProperty(ref _subjectsAttendance, value);
        }

        public ObservableCollection<ScheduleLessonItem> Schedule
        {
            get => _schedule;
            set => SetProperty(ref _schedule, value);
        }

        public double OverallAverage
        {
            get => _overallAverage;
            set => SetProperty(ref _overallAverage, value);
        }

        public double OverallAttendance
        {
            get => _overallAttendance;
            set => SetProperty(ref _overallAttendance, value);
        }
        #endregion

        #region Commands
        public ICommand LogoutCommand { get; }
        #endregion
        
    }

    #region Helper Classes
    public class SubjectGrades
    {
        public Subject Subject { get; set; }
        public ObservableCollection<Grade> Grades { get; set; } = new ObservableCollection<Grade>();
        public double SubjectAverage { get; set; }
        public int FinalGrade { get; set; }
    }

    public class SubjectAttendance
    {
        public string SubjectName { get; set; }
        public double AttendancePercent { get; set; }
        public int PresentCount { get; set; }
        public int LateCount { get; set; }
        public int TotalCount { get; set; }

        public string DetailsStat => $"Present: {PresentCount}, Late: {LateCount}, Total: {TotalCount}";
    }

    public class AttendanceLesson
    {
        public DateTime Date { get; set; }
        public string Subject { get; set; }
        public string Status { get; set; }
        public string StatusColor { get; set; }

        public static string GetStatusName(int status)
        {
            return status switch
            {
                1 => "Present",
                2 => "Absent",
                3 => "Late",
                _ => "Unknown"
            };
        }

        public static string GetStatusColor(int status)
        {
            return status switch
            {
                1 => "#4CAF50",
                2 => "#F44336",
                3 => "#FFC107",
                _ => "#9E9E9E"
            };
        }
    }

    public class ScheduleLessonItem
    {
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public string SubjectName { get; set; }
        public string TeacherLastName { get; set; }
        public string DayOfWeek { get; set; }
        public int DayOfWeekNumber { get; set; }

        public string DayName
        {
            get
            {
                return DayOfWeek switch
                {
                    "Poniedzialek" => "Monday",
                    "Wtorek" => "Tuesday",
                    "Sroda" => "Wednesday",
                    "Czwartek" => "Thursday",
                    "Piatek" => "Friday",
                    _ => DayOfWeek
                };
            }
        }
    }
    #endregion
}

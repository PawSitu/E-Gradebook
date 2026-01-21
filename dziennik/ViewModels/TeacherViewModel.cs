using dziennik.Models;
using dziennik.Services;
using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Input;

namespace dziennik.ViewModels
{
    public class TeacherViewModel : BaseViewModel
    {
        private readonly MainViewModel _mainViewModel;
        private readonly GradeService _gradeService = new GradeService();
        private readonly AttendanceService _attendanceService = new AttendanceService();
        private readonly SubjectService _subjectService = new SubjectService();
        private readonly ClassService _classService = new ClassService();
        private readonly ScheduleService _scheduleService = new ScheduleService();

        private Teacher _teacher;
        private ObservableCollection<Subject> _assignedSubjects = new ObservableCollection<Subject>();
        private ObservableCollection<Class> _teacherClasses = new ObservableCollection<Class>();
        private ObservableCollection<Student> _classStudents = new ObservableCollection<Student>();

        private Subject _selectedSubject;
        private Class _selectedClass;
        private Student _selectedStudent;
        private ObservableCollection<Grade> _studentGrades = new ObservableCollection<Grade>();
        private ObservableCollection<Attendance> _studentAttendances = new ObservableCollection<Attendance>();
        private Attendance _selectedAttendance;

        public Teacher Teacher => _teacher;

        public string FullName => $"{_teacher.Person.FirstName} {_teacher.Person.LastName}";
        private double _newGradeValue;
        private int _newAttendanceStatus = 1;
        private double _subjectAttendancePercent;
        private string _subjectAttendanceDetails;
        private string _errorMessage;
        private bool _showAttendance;
        private double _subjectAverage;
        private int _finalGrade;
        private Grade _selectedGrade;
        private bool _editMode = false;

        public TeacherViewModel(Teacher teacher, MainViewModel mainViewModel)
        {
            _teacher = teacher;
            _mainViewModel = mainViewModel;

            LogoutCommand = new RelayCommand(Logout);
            LoadClassesCommand = new RelayCommand(async () => await LoadTeacherClasses());
            LoadStudentsCommand = new RelayCommand<Class>(LoadStudents, cls => cls != null);
            LoadStudentDataCommand = new RelayCommand<Student>(LoadStudentData, student => student != null);
            AddGradeCommand = new RelayCommand(AddGrade, CanAddGrade);
            DeleteGradeCommand = new RelayCommand<Grade>(DeleteGrade, grade => grade != null);
            AddAttendanceCommand = new RelayCommand(AddAttendance, CanAddAttendance);
            EditAttendanceCommand = new RelayCommand(EditAttendance, CanEditAttendance);
            DeleteAttendanceCommand = new RelayCommand(DeleteAttendance, CanDeleteAttendance);
            EditGradeCommand = new RelayCommand(EditGrade, CanEditGrade);
            CancelEditCommand = new RelayCommand(CancelEdit, () => EditMode);

            LoadTeacherData();
        }

        #region Methods
        private async void LoadTeacherData()
        {
            try
            {
                var subjects = await _subjectService.GetTeacherSubjects(_teacher.Id);
                AssignedSubjects = new ObservableCollection<Subject>(subjects);

                await LoadTeacherClasses();
            }
            catch (Exception ex)
            {
                ErrorMessage = $"An error occurred: {ex.Message}";
            }
        }

        private async Task LoadTeacherClasses()
        {
            try
            {
                var schedule = await _scheduleService.GetTeacherSchedule(_teacher.Id);

                var classes = schedule
                    .GroupBy(pz => pz.ClassId)
                    .Select(g => g.First().Class)
                    .ToList();

                TeacherClasses = new ObservableCollection<Class>(classes);
            }
            catch (Exception ex)
            {
                ErrorMessage = $"Error loading classes: {ex.Message}";
            }
        }

        private async void LoadStudents(Class cls)
        {
            if (cls == null) return;

            try
            {
                bool teaches = await _scheduleService.DoesTeacherTeachClass(_teacher.Id, cls.Id);

                if (!teaches)
                {
                    ErrorMessage = "You don't teach this class";
                    ClassStudents.Clear();
                    return;
                }

                ErrorMessage = string.Empty;
                SelectedClass = cls;
                var students = await _classService.GetClassStudents(cls.Id);
                var sortedStudents = students
                    .OrderBy(u => u.Person.LastName)
                    .ThenBy(u => u.Person.FirstName)
                    .ToList();
                ClassStudents = new ObservableCollection<Student>(sortedStudents);
            }
            catch (Exception ex)
            {
                ErrorMessage = $"Error loading students: {ex.Message}";
            }
        }

        private async void LoadStudentData(Student student)
        {
            if (student == null || SelectedSubject == null)
            {
                ShowAttendance = false;
                return;
            }

            try
            {
                SelectedStudent = student;
                ShowAttendance = true;

                var grades = await _gradeService.GetStudentGradesBySubject(student.Id, SelectedSubject.Id);
                StudentGrades = new ObservableCollection<Grade>(grades);

                var attendances = await _attendanceService.GetStudentAttendancesBySubject(student.Id, SelectedSubject.Id);
                StudentAttendances = new ObservableCollection<Attendance>(attendances);

                CalculateSubjectAttendance();
            }
            catch (Exception ex)
            {
                ErrorMessage = $"Error loading student data: {ex.Message}";
            }
        }

        private bool CanAddGrade()
        {
            if (SelectedStudent == null || SelectedSubject == null || EditMode)
                return false;

            if (NewGradeValue < 1 || NewGradeValue > 6)
                return false;

            return true;
        }

        private async void AddGrade()
        {
            if (!CanAddGrade()) return;

            try
            {
                bool teaches = await _scheduleService.DoesTeacherTeachClass(_teacher.Id, SelectedStudent.ClassId);

                if (!teaches)
                {
                    ErrorMessage = "You cannot add a grade for this student";
                    return;
                }

                var lessonId = await _subjectService.GetLessonIdForTeacherAndSubject(
                    _teacher.Id, SelectedSubject.Id);

                var newGrade = new Grade
                {
                    StudentId = SelectedStudent.Id,
                    LessonId = lessonId,
                    Value = NewGradeValue,
                    IssueDate = DateTime.Now
                };

                await _gradeService.AddGrade(newGrade);
                ErrorMessage = "Grade has been added";
                LoadStudentData(SelectedStudent);
            }
            catch (Exception ex)
            {
                ErrorMessage = $"Error adding grade: {ex.Message}";
            }
        }

        private async void DeleteGrade(Grade grade)
        {
            if (grade == null) return;

            try
            {
                await _gradeService.DeleteGrade(grade.Id);
                ErrorMessage = "Grade has been deleted";
                LoadStudentData(SelectedStudent);
            }
            catch (Exception ex)
            {
                ErrorMessage = $"Error deleting grade: {ex.Message}";
            }
        }

        private bool CanAddAttendance()
        {
            return SelectedStudent != null && SelectedSubject != null;
        }

        private async void AddAttendance()
        {
            if (!CanAddAttendance()) return;

            try
            {
                var lessonId = await _subjectService.GetLessonIdForTeacherAndSubject(
                    _teacher.Id, SelectedSubject.Id);

                if (lessonId <= 0)
                {
                    ErrorMessage = $"Error: Invalid lesson ID ({lessonId})";
                    return;
                }

                var newAttendance = new Attendance
                {
                    StudentId = SelectedStudent.Id,
                    LessonId = lessonId,
                    Date = DateTime.Now,
                    Status = NewAttendanceStatus
                };

                await _attendanceService.AddAttendance(newAttendance);
                ErrorMessage = $"Attendance for subject {SelectedSubject.Name} has been added: {AttendanceLesson.GetStatusName(NewAttendanceStatus)}";

                LoadStudentData(SelectedStudent);
            }
            catch (Exception ex)
            {
                ErrorMessage = $"Error adding attendance: {ex.Message}";
            }
        }

        private bool CanEditAttendance()
        {
            return SelectedAttendance != null;
        }
        private async void EditAttendance()
        {
            if (SelectedAttendance == null) return;

            try
            {
                SelectedAttendance.Status = NewAttendanceStatus;

                await _attendanceService.UpdateAttendance(SelectedAttendance);

                ErrorMessage = $"Attendance has been updated: {AttendanceLesson.GetStatusName(NewAttendanceStatus)}";

                LoadStudentData(SelectedStudent);
            }
            catch (Exception ex)
            {
                ErrorMessage = $"Error updating attendance: {ex.Message}";
            }
        }

        private bool CanDeleteAttendance()
        {
            return SelectedAttendance != null;
        }

        private async void DeleteAttendance()
        {
            if (SelectedAttendance == null) return;

            try
            {
                await _attendanceService.DeleteAttendance(SelectedAttendance.Id);
                ErrorMessage = "Attendance has been deleted";

                LoadStudentData(SelectedStudent);
            }
            catch (Exception ex)
            {
                ErrorMessage = $"Error deleting attendance: {ex.Message}";
            }
        }

        private void CalculateSubjectAttendance()
        {
            if (StudentAttendances == null || StudentAttendances.Count == 0)
            {
                SubjectAttendancePercent = 0;
                SubjectAttendanceDetails = "No attendance data";
            }
            else
            {
                int total = StudentAttendances.Count;
                int present = StudentAttendances.Count(f => f.Status == 1); // 1 -> Present
                int late = StudentAttendances.Count(f => f.Status == 3); // 3 -> Late

                SubjectAttendancePercent = Math.Round(100.0 * (present + late) / total, 2);
                SubjectAttendanceDetails = $"Present: {present}, Late: {late}, Absent: {total - present - late}, Total: {total}";
            }

            if (StudentGrades == null || StudentGrades.Count == 0)
            {
                SubjectAverage = 0;
                FinalGrade = 0;
            }
            else
            {
                SubjectAverage = Math.Round(StudentGrades.Average(o => o.Value), 2);
                FinalGrade = (int)Math.Round(SubjectAverage);
            }
        }

        private bool CanEditGrade()
        {
            return SelectedGrade != null && NewGradeValue >= 1 && NewGradeValue <= 6;
        }

        private async void EditGrade()
        {
            if (!CanEditGrade()) return;

            try
            {
                SelectedGrade.Value = NewGradeValue;
                await _gradeService.UpdateGrade(SelectedGrade);

                ErrorMessage = "Grade has been updated";
                CancelEdit();
                LoadStudentData(SelectedStudent);
            }
            catch (Exception ex)
            {
                ErrorMessage = $"Error updating grade: {ex.Message}";
            }
        }

        private void CancelEdit()
        {
            SelectedGrade = null;
            EditMode = false;
        }
        private void Logout()
        {
            _mainViewModel.Logout();
        }
        #endregion
        #region Getters/Setters

        public ObservableCollection<Subject> AssignedSubjects
        {
            get => _assignedSubjects;
            set => SetProperty(ref _assignedSubjects, value);
        }

        public Subject SelectedSubject
        {
            get => _selectedSubject;
            set
            {
                if (SetProperty(ref _selectedSubject, value))
                {
                    (AddAttendanceCommand as RelayCommand)?.RaiseCanExecuteChanged();

                    if (SelectedStudent != null)
                    {
                        LoadStudentData(SelectedStudent);
                    }
                }
            }
        }

        public ObservableCollection<Class> TeacherClasses
        {
            get => _teacherClasses;
            set => SetProperty(ref _teacherClasses, value);
        }

        public Class SelectedClass
        {
            get => _selectedClass;
            set => SetProperty(ref _selectedClass, value);
        }

        public ObservableCollection<Student> ClassStudents
        {
            get => _classStudents;
            set => SetProperty(ref _classStudents, value);
        }

        public Student SelectedStudent
        {
            get => _selectedStudent;
            set
            {
                if (SetProperty(ref _selectedStudent, value))
                {
                    ShowAttendance = value != null;
                    (AddAttendanceCommand as RelayCommand)?.RaiseCanExecuteChanged();

                    if (value != null && SelectedSubject != null)
                    {
                        LoadStudentData(value);
                    }
                }
            }
        }

        public ObservableCollection<Grade> StudentGrades
        {
            get => _studentGrades;
            set => SetProperty(ref _studentGrades, value);
        }

        public double NewGradeValue
        {
            get => _newGradeValue;
            set
            {
                if (SetProperty(ref _newGradeValue, value))
                {
                    (AddGradeCommand as RelayCommand)?.RaiseCanExecuteChanged();
                }
            }
        }

        public ObservableCollection<Attendance> StudentAttendances
        {
            get => _studentAttendances;
            set => SetProperty(ref _studentAttendances, value);
        }

        public int NewAttendanceStatus
        {
            get => _newAttendanceStatus;
            set
            {
                if (SetProperty(ref _newAttendanceStatus, value))
                {
                    (AddAttendanceCommand as RelayCommand)?.RaiseCanExecuteChanged();
                }
            }
        }

        public Attendance SelectedAttendance
        {
            get => _selectedAttendance;
            set
            {
                if (SetProperty(ref _selectedAttendance, value))
                {
                    if (value != null)
                    {
                        NewAttendanceStatus = value.Status;
                    }

                    (EditAttendanceCommand as RelayCommand)?.RaiseCanExecuteChanged();
                    (DeleteAttendanceCommand as RelayCommand)?.RaiseCanExecuteChanged();
                }
            }
        }
        public double SubjectAttendancePercent
        {
            get => _subjectAttendancePercent;
            set => SetProperty(ref _subjectAttendancePercent, value);
        }

        public string SubjectAttendanceDetails
        {
            get => _subjectAttendanceDetails;
            set => SetProperty(ref _subjectAttendanceDetails, value);
        }
        public string ErrorMessage
        {
            get => _errorMessage;
            set => SetProperty(ref _errorMessage, value);
        }
        public bool ShowAttendance
        {
            get => _showAttendance;
            set => SetProperty(ref _showAttendance, value);
        }
        public double SubjectAverage
        {
            get => _subjectAverage;
            set => SetProperty(ref _subjectAverage, value);
        }

        public int FinalGrade
        {
            get => _finalGrade;
            set => SetProperty(ref _finalGrade, value);
        }

        public Grade SelectedGrade
        {
            get => _selectedGrade;
            set
            {
                if (SetProperty(ref _selectedGrade, value))
                {
                    if (value != null)
                    {
                        NewGradeValue = value.Value;
                        EditMode = true;
                    }
                    else
                    {
                        EditMode = false;
                    }

                    (EditGradeCommand as RelayCommand)?.RaiseCanExecuteChanged();
                    (CancelEditCommand as RelayCommand)?.RaiseCanExecuteChanged();
                }
            }
        }
        public bool EditMode
        {
            get => _editMode;
            set => SetProperty(ref _editMode, value);
        }
        #endregion
        #region Commands
        public ICommand LogoutCommand { get; }
        public ICommand LoadClassesCommand { get; }
        public ICommand LoadStudentsCommand { get; }
        public ICommand LoadStudentDataCommand { get; }
        public ICommand AddGradeCommand { get; }
        public ICommand DeleteGradeCommand { get; }
        public ICommand AddAttendanceCommand { get; }
        public ICommand EditAttendanceCommand { get; }
        public ICommand DeleteAttendanceCommand { get; }
        public ICommand EditGradeCommand { get; }
        public ICommand CancelEditCommand { get; }
        #endregion
        
    }
}

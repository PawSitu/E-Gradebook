using dziennik.Models;
using System.Windows.Input;
using System;

namespace dziennik.ViewModels
{
    public class MainViewModel : BaseViewModel
    {
        private object _currentViewModel;
        private Person _loggedInUser;

        public MainViewModel()
        {
            CurrentViewModel = new LoginViewModel(this);
        }

        #region Methods
        public void NavigateToStudentPanel(Student student)
        {
            CurrentViewModel = new StudentViewModel(student, this);
        }

        public void NavigateToTeacherPanel(Teacher teacher)
        {
            CurrentViewModel = new TeacherViewModel(teacher, this);
        }

        public void NavigateToAdminPanel(Admin admin)
        {
            CurrentViewModel = new AdminViewModel(admin, this);
        }

        public void Logout()
        {
            LoggedInUser = null; 
            CurrentViewModel = new LoginViewModel(this);
        }
        #endregion
        #region Getters/Setters
        public object CurrentViewModel
        {
            get => _currentViewModel;
            set => SetProperty(ref _currentViewModel, value);
        }

        public Person LoggedInUser
        {
            get => _loggedInUser;
            set => SetProperty(ref _loggedInUser, value);
        }
        #endregion
    }
}
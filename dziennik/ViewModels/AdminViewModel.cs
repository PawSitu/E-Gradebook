using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using dziennik.Models;
using dziennik.Services;

namespace dziennik.ViewModels
{
    class AdminViewModel : BaseViewModel
    {
        private readonly MainViewModel _mainViewModel;

        private Admin _admin;

        public Admin Admin => _admin;
        public string FullName => $"{_admin.Person.FirstName} {_admin.Person.LastName}";

        public AdminViewModel(Admin admin, MainViewModel mainViewModel)
        {
            _mainViewModel = mainViewModel;

            LogoutCommand = new RelayCommand(Logout);

        }


        #region Methods
        private void Logout()
        {
            _mainViewModel.Logout();
        }
        #endregion
        #region Getters/Setters

        #endregion
        #region Commands
        public ICommand LogoutCommand { get; }

        #endregion
    }
}

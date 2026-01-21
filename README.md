# E-Gradebook

A school electronic gradebook system built with WPF (.NET 8) using the MVVM pattern.

![.NET](https://img.shields.io/badge/.NET-8.0-512BD4?logo=dotnet)
![WPF](https://img.shields.io/badge/WPF-Windows-0078D4?logo=windows)
![SQLite](https://img.shields.io/badge/SQLite-Database-003B57?logo=sqlite)
![License](https://img.shields.io/badge/License-MIT-green)

## ?? Features

### For Teachers
- View assigned classes and subjects
- Grade management (add, edit, view)
- Student attendance tracking
- Calculate averages and statistics

### For Students
- View grades for all subjects
- Check attendance records
- Access class schedule

### For Administrators
- User management system
- Database administration

## ??? Technologies

- **.NET 8** - Modern .NET platform
- **WPF** (Windows Presentation Foundation) - Desktop UI framework
- **SQLite** - Lightweight database
- **MVVM** - Architecture pattern
- **Microsoft.Data.Sqlite** - Database connectivity

## ?? Project Structure

```
E-Gradebook/
??? dziennik/
?   ??? Data/              # Database scripts and SQLite file
?   ??? Models/            # Data models
?   ??? ViewModels/        # MVVM ViewModels
?   ??? Views/             # XAML views
?   ??? Services/          # Data access services
?   ??? Converters/        # Value converters
??? dziennik.sln           # Solution file
??? README.md
```

## ?? Getting Started

### Prerequisites

- Windows 10/11
- Visual Studio 2022 or newer
- .NET 8 SDK

### Installation

1. Clone the repository
```bash
git clone https://github.com/PawSitu/E-Gradebook.git
cd E-Gradebook
```

2. Open the solution in Visual Studio
3. Build and run the project (Press F5 or use dotnet run)

## ?? Database

The project uses SQLite database. The initialization script is located at `dziennik/Data/dziennik.sql`.

### Test Login Credentials

The database comes pre-populated with test data:
- Login: `firstname.lastname`
- Password: `u{id}` (e.g., u1, u2, u3...)

**?? Note:** This is for testing purposes only. Never use plain text passwords in production!

## ?? Screenshots

_Coming soon..._

## ?? Contributing

This is an educational project. Feel free to fork and experiment!

## ?? License

This project is available under the MIT License - see the [LICENSE](LICENSE) file for details.

## ?? Author

Created as part of an educational project.

## ?? Disclaimer

This application is designed for educational purposes and demonstration. It should not be used in a production environment without implementing proper security measures, especially regarding password storage and user authentication.

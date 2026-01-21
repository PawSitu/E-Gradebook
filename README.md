# E-Dziennik

Aplikacja E-Dziennik to system elektronicznego dziennika szkolnego zbudowany w technologii WPF (.NET 8) z wykorzystaniem wzorca MVVM.

## Funkcjonalnoœci

### Dla Nauczycieli
- Przegl¹danie przypisanych klas i przedmiotów
- Wystawianie i edycja ocen
- Zarz¹dzanie frekwencj¹ uczniów
- Obliczanie œrednich i statystyk

### Dla Uczniów
- Przegl¹danie w³asnych ocen
- Sprawdzanie frekwencji
- Podgl¹d planu zajêæ

### Dla Administratorów
- Zarz¹dzanie u¿ytkownikami systemu
- Administracja baz¹ danych

## Technologie

- **.NET 8**
- **WPF** (Windows Presentation Foundation)
- **SQLite** - baza danych
- **MVVM** - wzorzec architektury

## Struktura projektu

```
dziennik/
??? Data/              # Skrypty bazy danych
??? Models/            # Modele danych
??? ViewModels/        # ViewModele (MVVM)
??? Views/             # Widoki XAML
??? Services/          # Serwisy dostêpu do danych
```

## Uruchomienie

1. Sklonuj repozytorium
2. Otwórz projekt w Visual Studio 2022 lub nowszym
3. Zbuduj rozwi¹zanie
4. Uruchom aplikacjê

## Baza danych

Projekt wykorzystuje bazê SQLite. Skrypt inicjalizacyjny znajduje siê w pliku `dziennik/Data/dziennik.sql`.

### Domyœlne dane logowania

Szczegó³y dostêpu znajduj¹ siê w pliku SQL z danymi testowymi.

## Autorzy

Projekt stworzony jako czêœæ projektu edukacyjnego.

## Licencja

Ten projekt jest dostêpny na potrzeby edukacyjne.

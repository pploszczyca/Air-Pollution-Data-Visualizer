# Opis Backendu
## Architektura
1. **Kontrolery** - określamy w nich API (operacje GET, POST, PUT, DELETE), żądania przekazujemy dalej do _Serwisów_,
2. **Serwisy** - warsta pośrednicząca pomiędzy _Kontrolerami_ a _Use Case'ami_, podejście jeden _Serwis_ na jeden _Kontroler_,
3. **Use Case'y** - wykonują pewną logikę biznesową, idea częściowo wzorowana na wzorcu bechawioralnym [Command](https://refactoring.guru/pl/design-patterns/command), podejście stosowane w Clean Architecture, każdy _Use Case_ posiada interfejs, oraz klasę implementującą ją,
4. **Repozytoria/Mappery** - warstwa, w której wykonujemy operacje CRUD'owe dla _Modeli_, oraz mapujemy _Modele_ na inne obiekty,
5. **Modele** - obiekty reprezentujące strukturę danych.

## Podejście do porządkowania klas
W projekcie zastosowano podział wg warstw, np. wszystkie kontrolery znajdują się w jednym miejscu, w pakiecie _controllers_.

## Opis pakietów
- _annotations_ - własne adnotacje,
- _configs_ - klasy związane z konfiguracją aplikacji oraz _bean'ów_,
- _controllers_ - znajdują się tu wszystkie klasy kontrolerów związane z API,
- _deserializer_ - zawiera interfejs wraz z implementajcą służącą do odczytywania danych z endpointów z serwisu Datahub,
- _exceptions_ - własne wyjątki, oraz handlery,
- _models_
  - *body_models* - modele związane z odpowiedziemi kontrolerów,
  - *database* - modele znajdujące się w bazie danych,
- _repositories_ - repozytoria dla modeli bazodanowych, wszystkie opierają się o interfejs _CRUDRepository_,
- _services_ - serwisy dla poszczególnych kontrolerów,
- *use_cases* - logika biznesowa aplikacji,
- _utilites_ - dodatkowe narzędzia, np. do obsługi listy, streamów,
- _validators_ - klasy służące do sprawdzania poprawności danych, np. czy adres email jest poprawny.
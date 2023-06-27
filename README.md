# swapi-async-await

# Richiesta

Realizza una piccola App che visualizzi la lista dei personaggi forniti da Swapi (The Star Wars API). 
L'app dovrà essere composta da una Home con la lista di personaggi, e dal dettaglio del personaggio che si aprirà al tap sulla cella relativa in home.
Creati un branch col tuo nome e inizia pure.

## Home

Nel progetto già trovi HomeViewController e l'endpoint `SwapiEndpoint.people`da chiamare. L'impaginazione dovrà contenere una lista che visualizzi: 
- `name`
- `skin_color`
- `mass`

per ogni personaggio.

### Bonus home (facoltativo)
Implementa la paginazione dei personaggi. Nella prima chiamata, in risposta avrai una struttura dati che contiene `next`, la URL della successiva pagina. Quando non c'è una pagina successiva perché si è arrivati all'ultima, il valore della URL sarà `null`.

## Detail

Nel progetto già trovi DetailViewController, che deve contenere:

- `name` del personaggio
- `name` dei `vehicles` guidati dal personaggio. Ogni personaggio ha un array di URLs dei films in cui compare. Fai una chiamata parallela di tutte le URLs e ricava i modelli, da cui poi devi estrapolare il `name` di ciascuno.
- `title` dei `films` in cui compare il personaggio. Ogni personaggio ha un array di URLs dei films in cui compare. Fai una chiamata parallela di tutte le URLs e ricava i modelli, da cui poi devi estrapolare il `title` di ciascuno.

## Info utili
Ciascun modello di risposta contiene un campo `url` che indica la URL di sé stesso e quindi è un campo univoco usabile anche come ID.

## Vincoli

- ovviamente usa Async-Await
- usa UIKit

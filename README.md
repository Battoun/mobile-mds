# SensorHub

Application Flutter de supervision de capteurs connectés simulés : projet fil rouge du module **Applications mobiles et connectées** (M2 DFS, 45 h 30).

Stack : Flutter · MVVM + Clean Architecture · Freezed · MQTT (Mosquitto) · InfluxDB.

```
Capteurs virtuels ──MQTT/TLS──▶ Mosquitto ──▶ Backend ──▶ InfluxDB
                                    │            │ HTTPS
                                    └── temps réel ──▶ Application Flutter
```

## Lancer le projet

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # après chaque modif d'un modèle Freezed ou d'une route
flutter run
```

Pour iOS dans Xcode : ouvrir `ios/Runner.xcworkspace`.

## Architecture actuelle

```
lib/
├── main.dart                         # point d'entrée, thème
├── models/sensor.dart                # Model immutable (Freezed + JSON)
├── data/sensors.dart                 # données simulées (kSensors)
├── repositories/
│   ├── sensor_repository.dart        # contrat (abstract interface class)
│   └── fake_sensor_repository.dart   # implémentation simulée (données, latence, erreur)
├── view_models/
│   ├── async_state.dart              # sealed AsyncState : Loading / Content / Failure
│   └── dashboard_view_model.dart     # ChangeNotifier
├── screens/                          # dashboard + détail d'un capteur
├── widgets/sensor_card.dart
└── router/app_router.dart            # go_router (routes typées)
```

Flux : `View → ViewModel → SensorRepository (contrat) → FakeSensorRepository`

---

## Programme du module

| Bloc | Séances | Objectif |
|---|---|---|
| 1. Construire | 1 à 3 | Application mobile et ses contrats |
| 2. Connecter | 4 à 6 | Application, broker et objets simulés |
| 3. Fiabiliser | 7 à 10 | Temps réel, données et sécurité |
| 4. Livrer | 11 à 13 | Solution testée, observable et déployable |

### Jalons

| Quand | Ce qu'il faut pouvoir montrer |
|---|---|
| Après 7 h | Une application Flutter structurée en MVVM |
| Après 21 h | Flutter reçoit plusieurs capteurs simulés par MQTT |
| Après 35 h | Le système est temps réel, offline et sécurisé |
| Après 45 h 30 | Le produit est testé, déployable et présenté |

### Séances

| # | Contenu | Résultat attendu |
|---|---|---|
| 1 | Flutter, Freezed et contrats MVVM | Interface statique et Repository simulé |
| 2 | ViewModel, états scellés, Provider et tests | Application structurée et testable |
| 3 | Simulateur IoT, topics MQTT et JSON | Contrats de messages documentés |
| 4 | Mosquitto, publish/subscribe, QoS et LWT | Broker local opérationnel |
| 5 | Flotte simulée, commandes et pannes | Scénarios IoT reproductibles |
| 6 | Repository MQTT, streams et reconnexion | Mesures reçues dans Flutter |
| 7 | Graphiques, fraîcheur et alertes locales | Dashboard temps réel |
| 8 | Cache, retry et commandes différées | Mode offline-first |
| 9 | Backend HTTP et InfluxDB | Historique des mesures |
| 10 | TLS, comptes, ACL, RGPD et ETSI | Architecture durcie |
| 11 | Tests intégrés, logs, métriques et traces | Système observable |
| 12 | Build Android/iOS, CI et Docker Compose | Livraison reproductible |
| 13 | Challenge de panne et soutenance | Projet final démontré |

---

## MVP des 7 premières heures : étapes détaillées

Écrans attendus (le wireframe fixe les informations, pas le style) :

```
DASHBOARD                    DÉTAIL D'UN CAPTEUR
┌──────────────────────┐     ┌──────────────────────┐
│ SensorHub          ↻ │     │ ‹ Capteur du salon   │
│ Mes capteurs         │     │ ● En ligne           │
│ ┌──────────────────┐ │     │ Température  21,8°C  │
│ │ Salon      21,8° │ │     │ Humidité       45 %  │
│ │ 45 %    En ligne │ │     │ Batterie       82 %  │
│ └──────────────────┘ │     │ État             OK  │
│ ┌──────────────────┐ │     │ Dernière mesure      │
│ │ Garage     29,6° │ │     └──────────────────────┘
│ │ 61 %      Alerte │ │
│ └──────────────────┘ │
└──────────────────────┘
```

### ✅ Étape 1 : L'interface statique

- [x] créer le projet Flutter
- [x] créer le modèle immutable `Sensor` avec Freezed
- [x] ajouter `json_serializable` et lancer la génération
- [x] stocker provisoirement trois capteurs directement dans le widget
- [x] afficher ces capteurs dans une liste
- [x] extraire un widget `SensorCard`
- [x] distinguer visuellement un capteur hors ligne

**Terminé lorsque :** l'application démarre et affiche correctement la liste des capteurs.

### ✅ Étape 2 : Extraire le ViewModel

- [x] créer une classe `DashboardViewModel`
- [x] déplacer la liste statique du widget vers cette classe
- [x] rendre la liste privée et l'exposer en lecture seule
- [x] ajouter `sensorCount`, `onlineCount` et `hasOfflineSensors`
- [x] recevoir le ViewModel dans le constructeur de `DashboardPage`
- [x] construire la liste avec `viewModel.sensors`

**Terminé lorsque :** le dashboard affiche le même résultat, mais aucun capteur n'est déclaré dans la View.

### ✅ Étape 3 : Relier le Repository au ViewModel

Remplacer les données écrites dans le ViewModel par une source simulée asynchrone.

- [x] **Définir le contrat** : `abstract interface class SensorRepository { Future<List<Sensor>> fetchAll(); }`. Le ViewModel ne dépend que de cette interface.
- [x] **Créer le Fake** : données, latence et erreur configurables par le constructeur, sans infrastructure réelle.
- [x] **Charger** : injecter le Repository dans le ViewModel, qui remplace les données statiques. La View ne connaît pas le Repository.
- [x] Provisoirement : `await viewModel.load()` avant `runApp`

**Terminé lorsque :** le dashboard affiche les données du Fake et le ViewModel ne contient plus de liste statique.

### ✅ Étape 4 : Rendre le ViewModel réactif

Faire publier au ViewModel un état cohérent à chaque étape du chargement.

Contraintes :

- [x] pas de Provider ni de widget
- [x] un seul objet décrit l'état courant de l'écran (`AsyncState<Sensor>`)
- [x] les cas possibles forment une hiérarchie fermée (`sealed` : `Loading`, `Content`, `Failure`)
- [x] l'état est lisible mais non remplaçable de l'extérieur (`_state` privé + getter)
- [x] le ViewModel notifie après chaque transition (`_setState` → `notifyListeners()`)

**Terminé lorsque :** un listener observe les états publiés sans Provider ni widget (voir `main.dart`).

### ⏳ Étapes suivantes de la séance 2 (supports pas encore reçus)

D'après le programme (« ViewModel, états scellés, Provider et tests ») et les objectifs des 7 h :

- [ ] **Provider** : exposer le ViewModel dans l'arbre avec `ChangeNotifierProvider` et reconstruire la View à chaque notification
- [ ] **Rendu exhaustif** : `switch` sur `AsyncState` dans la View (`LoadingView`, `EmptyView`, `ContentView`, `ErrorView`), sans cas `_`
- [ ] retirer le `await viewModel.load()` placé avant `runApp`
- [ ] bouton ↻ du dashboard qui relance `load()`
- [ ] **Tests** du ViewModel avec le `FakeSensorRepository` (succès, erreur, ordre des états publiés)

Objectifs des 7 h : composer un écran avec des widgets · faire évoluer l'UI à partir d'un état · MVVM · Provider + `ChangeNotifier` · Repository · états Loading / Content / Error · tester un ViewModel.

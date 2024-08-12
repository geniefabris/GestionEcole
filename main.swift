import Foundation

// Déclaration des variables
var etudiants: [[String: Any]] = []
var idCounter = 1

// Fonction pour ajouter un étudiant
func ajouterEtudiant() {
    print("Entrez le prénom de l'étudiant :")
    guard let prenom = readLine() else { return }

    print("Entrez le nom de l'étudiant :")
    guard let nom = readLine() else { return }

    let etudiant: [String: Any] = [
        "id": idCounter,
        "prenom": prenom,
        "nom": nom,
        "notes": ["Maths": 0.0, "POO": 0.0, "Genie Logiciel": 0.0, "Methodologie": 0.0]
    ]
    etudiants.append(etudiant)
    print("Étudiant \(prenom) \(nom) ajouté avec succès avec ID \(idCounter) !")
    idCounter += 1
}

// Fonction pour lister les étudiants
func listerEtudiants() {
    print("Liste des étudiants :")
    for etudiant in etudiants {
        if let id = etudiant["id"] as? Int, let prenom = etudiant["prenom"] as? String, let nom = etudiant["nom"] as? String {
            print("ID: \(id) - \(prenom) \(nom)")
        }
    }
}

// Fonction pour ajouter des notes à un étudiant
func ajouterNoteEtudiant() {
    listerEtudiants()
    print("Entrez l'ID de l'étudiant pour ajouter des notes : ", terminator: "")
    if let choix = readLine(), let id = Int(choix) {
        if let index = etudiants.firstIndex(where: { $0["id"] as? Int == id }) {
            var etudiant = etudiants[index]
            if var notes = etudiant["notes"] as? [String: Double] {
                for matiere in notes.keys {
                    print("Entrez la note pour \(matiere) (sur 100) : ", terminator: "")
                    if let noteStr = readLine(), let note = Double(noteStr), note >= 0.0, note <= 100.0 {
                        notes[matiere] = note
                    } else {
                        print("Note invalide. La note doit être entre 0 et 100.")
                    }
                }
                etudiant["notes"] = notes
                etudiants[index] = etudiant
                print("Notes mises à jour pour \(etudiant["prenom"] as! String) \(etudiant["nom"] as! String).")
            }
        } else {
            print("Étudiant non trouvé.")
        }
    } else {
        print("ID invalide.")
    }
}

// Fonction pour calculer la moyenne d'un étudiant
func calculerMoyenneEtudiant() {
    listerEtudiants()
    print("Entrez l'ID de l'étudiant pour calculer la moyenne : ", terminator: "")
    if let choix = readLine(), let id = Int(choix) {
        if let etudiant = etudiants.first(where: { $0["id"] as? Int == id }) {
            if let notes = etudiant["notes"] as? [String: Double] {
                let total = notes.values.reduce(0, +)
                let moyenne = total / Double(notes.count)
                print("La moyenne de \(etudiant["prenom"] as! String) \(etudiant["nom"] as! String) est \(moyenne).")
            }
        } else {
            print("Étudiant non trouvé.")
        }
    } else {
        print("ID invalide.")
    }
}

// Fonction pour afficher le menu et gérer les options
func afficherMenu() {
    var continuer = true

    while continuer {
        print("\nMenu:")
        print("1. Ajouter un étudiant")
        print("2. Lister les étudiants")
        print("3. Ajouter des notes à un étudiant")
        print("4. Calculer la moyenne d'un étudiant")
        print("5. Quitter")
        print("Choisissez une option : ", terminator: "")

        if let choix = readLine() {
            switch choix {
            case "1":
                ajouterEtudiant()
            case "2":
                listerEtudiants()
            case "3":
                ajouterNoteEtudiant()
            case "4":
                calculerMoyenneEtudiant()
            case "5":
                continuer = false
                print("Au revoir!")
            default:
                print("Choix invalide.")
            }
        }
    }
}

// Appel de la fonction pour afficher le menu
afficherMenu()

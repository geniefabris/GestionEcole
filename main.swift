import Foundation

// Struct pour un étudiant
struct Etudiant {
    var id: String
    var prenom: String
    var notes: [String: Int] // Matières et leurs notes
}

// Struct pour la gestion des paiements
struct Paiement {
    var montantVerse: Int
    var frais: Int
}

// Variables globales
var etudiants: [String: Etudiant] = [:]
var paiements: [String: [Paiement]] = [:]

// Fonction pour ajouter un étudiant
func ajouterEtudiant() {
    print("Entrez l'ID de l'étudiant:")
    let id = readLine() ?? ""
    print("Entrez le prénom de l'étudiant:")
    let prenom = readLine() ?? ""

    // Initialiser les notes à 0 pour chaque matière
    let notes = ["Maths": 0, "POO": 0, "Genie Logiciel": 0, "Methodologie": 0]

    let etudiant = Etudiant(id: id, prenom: prenom, notes: notes)
    etudiants[id] = etudiant
    print("Étudiant ajouté avec succès.")
}

// Fonction pour lister les étudiants
func listerEtudiants() {
    for (id, etudiant) in etudiants {
        print("ID: \(id), Prénom: \(etudiant.prenom)")
    }
}

// Fonction pour ajouter une note
func ajouterNote() {
    print("Entrez l'ID de l'étudiant:")
    let id = readLine() ?? ""

    guard var etudiant = etudiants[id] else {
        print("Étudiant non trouvé.")
        return
    }

    print("Entrez la matière (Maths, POO, Genie Logiciel, Methodologie):")
    let matiere = readLine() ?? ""

    print("Entrez la note (sur 100):")
    if let note = Int(readLine() ?? ""), note >= 0 && note <= 100 {
        etudiant.notes[matiere] = note
        etudiants[id] = etudiant
        print("Note ajoutée avec succès.")
    } else {
        print("Note invalide. Veuillez entrer une note entre 0 et 100.")
    }
}

// Fonction pour calculer la note moyenne
func calculerNote() {
    print("Entrez l'ID de l'étudiant:")
    let id = readLine() ?? ""

    guard let etudiant = etudiants[id] else {
        print("Étudiant non trouvé.")
        return
    }

    let totalNotes = etudiant.notes.values.reduce(0, +)
    let moyenne = Double(totalNotes) / Double(etudiant.notes.count)
    print("La moyenne de \(etudiant.prenom) est \(moyenne).")
}

// Fonction pour faire un paiement
func faireUnPaiement() {
    print("Entrez l'ID de l'étudiant:")
    let id = readLine() ?? ""

    print("Entrez le montant versé:")
    if let montantVerse = Int(readLine() ?? ""), montantVerse >= 0 {
        let frais = 5000
        let paiement = Paiement(montantVerse: montantVerse, frais: frais)

        if paiements[id] != nil {
            paiements[id]?.append(paiement)
        } else {
            paiements[id] = [paiement]
        }

        print("Paiement enregistré avec succès.")
    } else {
        print("Montant invalide.")
    }
}

// Fonction pour lister les paiements
func listerPaiements() {
    print("Entrez l'ID de l'étudiant:")
    let id = readLine() ?? ""

    guard let paiementsEtudiant = paiements[id] else {
        print("Aucun paiement trouvé pour cet étudiant.")
        return
    }

    for paiement in paiementsEtudiant {
        print("Montant versé: \(paiement.montantVerse), Frais: \(paiement.frais)")
    }
}

// Fonction pour afficher le solde
func afficherSolde() {
    print("Entrez l'ID de l'étudiant:")
    let id = readLine() ?? ""

    guard let paiementsEtudiant = paiements[id] else {
        print("Aucun paiement trouvé pour cet étudiant.")
        return
    }

    let montantTotal = paiementsEtudiant.map { $0.montantVerse }.reduce(0, +)
    let fraisTotal = paiementsEtudiant.map { $0.frais }.reduce(0, +)
    let solde = montantTotal - fraisTotal
    print("Solde pour l'étudiant \(id): \(solde)")
}

// Fonction pour afficher le menu de gestion des étudiants
func menuGestionEtudiant() {
    while true {
        print("""
        Menu Gestion Etudiant:
        1. Ajouter un étudiant
        2. Lister les étudiants
        3. Ajouter une note
        4. Calculer la note moyenne
        5. Retourner au menu principal
        Choisissez une option :
        """, terminator: "")

        switch readLine() {
        case "1":
            ajouterEtudiant()
        case "2":
            listerEtudiants()
        case "3":
            ajouterNote()
        case "4":
            calculerNote()
        case "5":
            return
        default:
            print("Option invalide, veuillez réessayer.")
        }
    }
}

// Fonction pour afficher le menu de gestion des économats
func menuGestionEconomat() {
    while true {
        print("""
        Menu Gestion Economat:
        1. Faire un paiement
        2. Lister les paiements
        3. Afficher le solde
        4. Retourner au menu principal
        Choisissez une option :
        """, terminator: "")

        switch readLine() {
        case "1":
            faireUnPaiement()
        case "2":
            listerPaiements()
        case "3":
            afficherSolde()
        case "4":
            return
        default:
            print("Option invalide, veuillez réessayer.")
        }
    }
}

// Fonction pour afficher le menu principal
func menuPrincipal() {
    while true {
        print("""
        Menu Principal:
        1. Gestion des Étudiants
        2. Gestion Economat
        3. Quitter
        Choisissez une option :
        """, terminator: "")

        switch readLine() {
        case "1":
            menuGestionEtudiant()
        case "2":
            menuGestionEconomat()
        case "3":
            print("Au revoir!")
            return
        default:
            print("Option invalide, veuillez réessayer.")
        }
    }
}

// Démarrer le menu principal
menuPrincipal()

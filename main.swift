import Foundation

// Structure pour représenter un étudiant
struct Etudiant {
    var id: String
    var nom: String
    var prenom: String
    var niveau: String
    var notes: [String: Int] = [:]
}

// Dictionnaire pour stocker les étudiants
var etudiants: [String: Etudiant] = [:]

// Fonction pour ajouter un étudiant
func ajouterEtudiant() {
    print("Entrez l'ID de l'étudiant:")
    let id = readLine() ?? ""

    guard etudiants[id] == nil else {
        print("Un étudiant avec cet ID existe déjà.")
        return
    }

    print("Entrez le nom de l'étudiant:")
    let nom = readLine() ?? ""

    print("Entrez le prénom de l'étudiant:")
    let prenom = readLine() ?? ""

    print("Entrez le niveau de l'étudiant:")
    let niveau = readLine() ?? ""

    let etudiant = Etudiant(id: id, nom: nom, prenom: prenom, niveau: niveau)
    etudiants[id] = etudiant
    print("Étudiant ajouté avec succès.")
}

// Fonction pour lister les étudiants
func listerEtudiants() {
    if etudiants.isEmpty {
        print("Aucun étudiant trouvé.")
    } else {
        for (id, etudiant) in etudiants {
            print("ID: \(id), Nom: \(etudiant.nom), Prénom: \(etudiant.prenom), Niveau: \(etudiant.niveau)")
        }
    }
}

// Fonction pour ajouter une note à un étudiant
func ajouterNote() {
    print("Entrez l'ID de l'étudiant:")
    let id = readLine() ?? ""

    guard var etudiant = etudiants[id] else {
        print("Étudiant non trouvé.")
        return
    }

    print("Entrez le nom de la matière:")
    let matiere = readLine() ?? ""

    print("Entrez la note (sur 100) pour \(matiere):")
    guard let note = Int(readLine() ?? ""), note >= 0, note <= 100 else {
        print("Note invalide. La note doit être un entier entre 0 et 100.")
        return
    }

    etudiant.notes[matiere] = note
    etudiants[id] = etudiant
    print("Note ajoutée avec succès.")
}

// Fonction pour calculer la moyenne des notes d'un étudiant
func calculerMoyenne() {
    print("Entrez l'ID de l'étudiant:")
    let id = readLine() ?? ""

    guard let etudiant = etudiants[id] else {
        print("Étudiant non trouvé.")
        return
    }

    if etudiant.notes.isEmpty {
        print("Aucune note trouvée pour cet étudiant.")
        return
    }

    let totalNotes = etudiant.notes.values.reduce(0, +)
    let moyenne = Double(totalNotes) / Double(etudiant.notes.count)

    print("La moyenne des notes de \(etudiant.prenom) \(etudiant.nom) est \(moyenne).")
}

// Fonction pour afficher le menu de gestion des étudiants
func menuGestionEtudiant() {
    while true {
        print("""
        Menu Gestion Etudiant:
        1. Ajouter un étudiant
        2. Lister les étudiants
        3. Ajouter une note
        4. Calculer la moyenne des notes
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
            calculerMoyenne()
        case "5":
            return
        default:
            print("Option invalide, veuillez réessayer.")
        }
    }
}

// Fonction pour gérer les paiements et la gestion économat
func menuGestionEconomat() {
    var versements: [String: [Double]] = [:] // Stockage des versements par étudiant
    let frais: Double = 5000 // Déclaré comme une constante car sa valeur ne change pas

    func faireUnPaiement() {
        print("Entrez l'ID de l'étudiant:")
        let id = readLine() ?? ""

        print("Entrez le montant du paiement:")
        guard let montant = Double(readLine() ?? ""), montant > 0 else {
            print("Montant invalide.")
            return
        }

        // Enregistrer le paiement
        var versement = versements[id] ?? []
        versement.append(montant)
        versements[id] = versement
        print("Paiement de \(montant) enregistré pour l'étudiant \(id).")
    }

    func listerVersements() {
        print("Entrez l'ID de l'étudiant:")
        let id = readLine() ?? ""

        guard let versement = versements[id] else {
            print("Aucun versement trouvé pour cet étudiant.")
            return
        }

        print("Versements pour l'étudiant \(id):")
        for (index, montant) in versement.enumerated() {
            print("Versement \(index + 1): \(montant)")
        }
    }

    func soldeEtudiant() {
        print("Entrez l'ID de l'étudiant:")
        let id = readLine() ?? ""

        let versementTotal = (versements[id] ?? []).reduce(0, +)
        let totalARegler = 3000 * 3 + frais // 3 versements de 3000 + frais

        let solde = totalARegler - versementTotal
        print("Solde restant pour l'étudiant \(id): \(solde)")
    }

    while true {
        print("""
        Menu Gestion Économat:
        1. Faire un paiement
        2. Lister les versements
        3. Vérifier le solde d'un étudiant
        4. Retourner au menu principal
        Choisissez une option :
        """, terminator: "")

        switch readLine() {
        case "1":
            faireUnPaiement()
        case "2":
            listerVersements()
        case "3":
            soldeEtudiant()
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
        2. Gestion Économat
        3. Quitter
        Choisissez une option :
        """, terminator: "")

        switch readLine() {
        case "1":
            menuGestionEtudiant()
        case "2":
            menuGestionEconomat()
        case "3":
            print("Au revoir !")
            return
        default:
            print("Option invalide, veuillez réessayer.")
        }
    }
}

// Lancer le menu principal
menuPrincipal()

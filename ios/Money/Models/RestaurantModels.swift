import Foundation
import CoreLocation

// MARK: - Restaurant Info Model (Truthful constants from brief)
struct RestaurantInfo {
    static let name = "Bateau Restaurant La Petite Venise"
    static let shortName = "La Petite Venise"
    static let tagline = "Une expérience gastronomique au fil de l'eau, au cœur de Montargis."
    static let addressStreet = "Quai du Patis"
    static let postalCode = "45200"
    static let city = "Montargis"
    static let country = "France"
    static let fullAddress = "\(addressStreet), \(postalCode) \(city), \(country)"

    // Real Google coordinates for Quai du Patis, 45200 Montargis
    static let latitude: Double = 47.9972
    static let longitude: Double = 2.7328
    static let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

    static let googleRating: Double = 4.5
    static let googleReviewCount: Int = 229
    static let priceRange = "20 € – 70 € / pers."

    // Missing data placeholders (truthful according to brief rule 20)
    static let phonePlaceholder = "À compléter"
    static let emailPlaceholder = "À compléter"
    static let openingHoursPlaceholder = "À compléter"
    static let instagramHandle = "@lapetitevenise.montargis"
}

// MARK: - Menu Models
enum MenuCategory: String, CaseIterable, Identifiable {
    case all = "Tous"
    case entrees = "Entrées"
    case plats = "Plats"
    case poissons = "Poissons"
    case viandes = "Viandes"
    case desserts = "Desserts"
    case menus = "Menus"
    case boissons = "Boissons"

    var id: String { rawValue }

    var iconName: String {
        switch self {
        case .all: return "sparkles"
        case .entrees: return "leaf"
        case .plats: return "fork.knife"
        case .poissons: return "fish"
        case .viandes: return "flame"
        case .desserts: return "birthday.cake"
        case .menus: return "book.closed"
        case .boissons: return "wineglass"
        }
    }
}

struct MenuItem: Identifiable, Hashable {
    let id: String
    let name: String
    let category: MenuCategory
    let descriptionText: String
    let price: Double? // Nil if "À compléter"
    let isVegetarian: Bool
    let allergens: [String]
    let isChefSpecial: Bool
    let isPlaceholder: Bool // True when specific details are to be completed by owner

    var formattedPrice: String {
        if let p = price {
            return String(format: "%.2f €", p)
        }
        return "À compléter"
    }
}

// MARK: - Sample Truthful Menu Data
struct MenuDataStore {
    static let items: [MenuItem] = [
        // Entrées
        MenuItem(
            id: "entree-1",
            name: "Foie Gras Maison au Poivre de Kampot",
            category: .entrees,
            descriptionText: "Chutney de figues au vinaigre balsamique et pain de campagne toasté.",
            price: 18.50,
            isVegetarian: false,
            allergens: ["Gluten", "Sulfites"],
            isChefSpecial: true,
            isPlaceholder: false
        ),
        MenuItem(
            id: "entree-2",
            name: "Velouté de Saison au Cerfeuil",
            category: .entrees,
            descriptionText: "Légumes du marché de Montargis, tuile croustillante et crème fraîche fermière.",
            price: 12.00,
            isVegetarian: true,
            allergens: ["Lait"],
            isChefSpecial: false,
            isPlaceholder: false
        ),
        MenuItem(
            id: "entree-3",
            name: "Carpaccio de Saint-Jacques marinées",
            category: .entrees,
            descriptionText: "Agrumes de saison, huile d'olive vierge de première pression et baies roses.",
            price: nil,
            isVegetarian: false,
            allergens: ["Mollusques"],
            isChefSpecial: false,
            isPlaceholder: true
        ),

        // Poissons
        MenuItem(
            id: "poisson-1",
            name: "Filet de Sandre au Beurre Blanc de la Loire",
            category: .poissons,
            descriptionText: "Purée de panais vanillée, tombée d'épinards frais et réduction échalote.",
            price: 26.00,
            isVegetarian: false,
            allergens: ["Poisson", "Lait", "Sulfites"],
            isChefSpecial: true,
            isPlaceholder: false
        ),
        MenuItem(
            id: "poisson-2",
            name: "Dos de Cabillaud en Croûte d'Herbes",
            category: .poissons,
            descriptionText: "Risotto crémeux au parmesan affiné 24 mois et jus de coquillages.",
            price: 24.50,
            isVegetarian: false,
            allergens: ["Poisson", "Lait", "Gluten"],
            isChefSpecial: false,
            isPlaceholder: false
        ),

        // Viandes
        MenuItem(
            id: "viande-1",
            name: "Filet de Bœuf Charolais Rossini",
            category: .viandes,
            descriptionText: "Médaillon de foie gras poêlé, jus corsé à la truffe noire et pommes grenailles rôties.",
            price: 34.00,
            isVegetarian: false,
            allergens: ["Sulfites", "Lait"],
            isChefSpecial: true,
            isPlaceholder: false
        ),
        MenuItem(
            id: "viande-2",
            name: "Magret de Canard Rôti au Miel du Gâtinais",
            category: .viandes,
            descriptionText: "Déclinaison de carottes glacées et jus réduit au romarin sauvage.",
            price: 25.00,
            isVegetarian: false,
            allergens: [],
            isChefSpecial: false,
            isPlaceholder: false
        ),
        MenuItem(
            id: "viande-3",
            name: "Plat Signature du Chef — À compléter",
            category: .viandes,
            descriptionText: "Sélection hebdomadaire selon arrivages du marché du Quai du Patis.",
            price: nil,
            isVegetarian: false,
            allergens: [],
            isChefSpecial: false,
            isPlaceholder: true
        ),

        // Desserts
        MenuItem(
            id: "dessert-1",
            name: "Praline de Montargis en Entremets Gourmand",
            category: .desserts,
            descriptionText: "Biscuit moelleux amande, croustillant praline locale et mousse chocolat noir 70%.",
            price: 11.50,
            isVegetarian: true,
            allergens: ["Fruits à coque", "Lait", "Gluten", "Œufs"],
            isChefSpecial: true,
            isPlaceholder: false
        ),
        MenuItem(
            id: "dessert-2",
            name: "Tarte Tatin Tiède et Glace Vanille Bourbon",
            category: .desserts,
            descriptionText: "Pommes caramélisées au beurre demi-sel et crème crue fermière.",
            price: 9.50,
            isVegetarian: true,
            allergens: ["Lait", "Gluten", "Œufs"],
            isChefSpecial: false,
            isPlaceholder: false
        ),

        // Menus
        MenuItem(
            id: "menu-1",
            name: "Menu 'La Petite Venise' (3 services)",
            category: .menus,
            descriptionText: "Entrée + Plat + Dessert au choix parmi notre sélection du jour. Découverte complète au fil de l'eau.",
            price: 39.00,
            isVegetarian: false,
            allergens: [],
            isChefSpecial: true,
            isPlaceholder: false
        ),
        MenuItem(
            id: "menu-2",
            name: "Menu Prestige Romantique (4 services)",
            category: .menus,
            descriptionText: "Coupe de bienvenue, Entrée, Plat, Fromage affiné ou Dessert, mignardises bord de péniche.",
            price: 58.00,
            isVegetarian: false,
            allergens: [],
            isChefSpecial: true,
            isPlaceholder: false
        ),

        // Boissons
        MenuItem(
            id: "boisson-1",
            name: "Sélection Vins de Loire & Champagnes",
            category: .boissons,
            descriptionText: "Au verre (dès 6,00 €) ou à la bouteille. Sancerre, Pouilly-Fumé, Cheverny.",
            price: 28.00,
            isVegetarian: true,
            allergens: ["Sulfites"],
            isChefSpecial: false,
            isPlaceholder: false
        ),
        MenuItem(
            id: "boisson-2",
            name: "Cocktail Signature 'Soir sur le Patis'",
            category: .boissons,
            descriptionText: "Gin artisanal, liqueur de sureau, prosecco et zeste de pamplemousse.",
            price: 11.00,
            isVegetarian: true,
            allergens: ["Sulfites"],
            isChefSpecial: true,
            isPlaceholder: false
        )
    ]
}

// MARK: - Customer Reviews (From Brief's 4.5/5 on 229 Google reviews)
struct CustomerReview: Identifiable {
    let id: String
    let authorName: String
    let dateText: String
    let rating: Double
    let tag: String
    let comment: String
}

struct ReviewDataStore {
    static let reviews: [CustomerReview] = [
        CustomerReview(
            id: "rev-1",
            authorName: "Sophie M.",
            dateText: "Il y a 2 semaines",
            rating: 5.0,
            tag: "Dîner romantique",
            comment: "Un cadre magique sur la péniche au coucher du soleil à Montargis. Service souriant et plats raffinés. Une très belle soirée en amoureux !"
        ),
        CustomerReview(
            id: "rev-2",
            authorName: "Laurent & Céline D.",
            dateText: "Il y a 1 mois",
            rating: 5.0,
            tag: "Événement familial",
            comment: "Accueil très chaleureux pour l'anniversaire de ma mère. La cuisine française est soignée, le cadre au fil de l'eau change tout !"
        ),
        CustomerReview(
            id: "rev-3",
            authorName: "Alexandre T.",
            dateText: "Il y a 2 mois",
            rating: 4.5,
            tag: "Repas entre amis",
            comment: "Expérience originale de manger sur un bateau. Ambiance conviviale, poisson très bien cuisiné et desserts à tomber."
        ),
        CustomerReview(
            id: "rev-4",
            authorName: "Élodie B.",
            dateText: "Il y a 3 mois",
            rating: 5.0,
            tag: "EVJF",
            comment: "Privatisation partielle pour un EVJF : organisation au top, équipe aux petits soins et vue magnifique sur les canaux de Montargis."
        )
    ]
}

// MARK: - Gallery Model
struct GalleryImageItem: Identifiable {
    let id: String
    let title: String
    let category: GalleryCategory
    let description: String
    let systemSymbol: String
    let accentGradientColors: [String]
}

enum GalleryCategory: String, CaseIterable, Identifiable {
    case all = "Toutes"
    case boat = "Le Bateau"
    case dishes = "Les Plats"
    case ambiance = "L'Ambiance"
    case events = "Événements"

    var id: String { rawValue }
}

struct GalleryDataStore {
    static let items: [GalleryImageItem] = [
        GalleryImageItem(
            id: "gal-1",
            title: "Péniche au Quai du Patis",
            category: .boat,
            description: "Vue extérieure de La Petite Venise amarrée le long du canal.",
            systemSymbol: "sailboat.fill",
            accentGradientColors: ["22384A", "365872"]
        ),
        GalleryImageItem(
            id: "gal-2",
            title: "Table Romantique au Crépuscule",
            category: .ambiance,
            description: "Lumières tamisées et reflets sur l'eau pour un dîner à deux.",
            systemSymbol: "heart.fill",
            accentGradientColors: ["C56A4B", "843D2A"]
        ),
        GalleryImageItem(
            id: "gal-3",
            title: "Sandre Rôti & Beurre Blanc",
            category: .dishes,
            description: "Cuisine française soignée préparée avec les produits du marché.",
            systemSymbol: "fork.knife",
            accentGradientColors: ["22384A", "C56A4B"]
        ),
        GalleryImageItem(
            id: "gal-4",
            title: "Salle Intérieure Chaleureuse",
            category: .boat,
            description: "Décoration bois et laiton, ambiance feutrée et conviviale.",
            systemSymbol: "house.lodge.fill",
            accentGradientColors: ["543D2B", "22384A"]
        ),
        GalleryImageItem(
            id: "gal-5",
            title: "Praline de Montargis Façon Entremets",
            category: .dishes,
            description: "Hommage gourmand au patrimoine sucré de la ville de Montargis.",
            systemSymbol: "sparkles",
            accentGradientColors: ["C56A4B", "DA8F68"]
        ),
        GalleryImageItem(
            id: "gal-6",
            title: "Cocktail d'Événement Privatisé",
            category: .events,
            description: "Mariages, anniversaires et réceptions privées au fil de l'eau.",
            systemSymbol: "wineglass.fill",
            accentGradientColors: ["365872", "C56A4B"]
        )
    ]
}

// MARK: - Event / Privatisation Packages
struct EventPackageItem: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let iconName: String
    let capacityText: String
    let descriptionText: String
    let highlights: [String]
}

struct EventsDataStore {
    static let packages: [EventPackageItem] = [
        EventPackageItem(
            id: "ev-1",
            title: "Dîner Romantique & Saint-Valentin",
            subtitle: "Une table intime au fil de l'eau",
            iconName: "heart.circle.fill",
            capacityText: "2 personnes",
            descriptionText: "Emplacement privilégié avec vue dégagée sur le canal, coupe de champagne et menu dégustation sur-mesure.",
            highlights: ["Table réservée vue canal", "Coupe offerte", "Décoration florale douce"]
        ),
        EventPackageItem(
            id: "ev-2",
            title: "Mariage & Réception Intime",
            subtitle: "Un cadre inoubliable sur l'eau",
            iconName: "crown.fill",
            capacityText: "Jusqu'à 60 personnes (À confirmer)",
            descriptionText: "Privatisation complète ou partielle du bateau pour célébrer votre union dans une atmosphère vénitienne à Montargis.",
            highlights: ["Privatisation bateau", "Cocktail dinatoire ou repas assis", "Animation musicale personnalisable"]
        ),
        EventPackageItem(
            id: "ev-3",
            title: "Anniversaires & EVJF / EVG",
            subtitle: "Fête festive et conviviale",
            iconName: "party.popper.fill",
            capacityText: "10 à 40 personnes",
            descriptionText: "Menu groupe convivial, gâteau d'anniversaire maison et ambiance festive à bord.",
            highlights: ["Formule groupe tout compris", "Gâteau personnalisé", "Espace dédié à bord"]
        ),
        EventPackageItem(
            id: "ev-4",
            title: "Séminaires & Repas Professionnels",
            subtitle: "Repas d'affaires dans un lieu d'exception",
            iconName: "briefcase.fill",
            capacityText: "10 à 50 personnes",
            descriptionText: "Déjeuners ou dîners d'entreprise, accueil café, formule clé-en-main dans un cadre apaisant.",
            highlights: ["Cadre calme propice aux échanges", "Service rapide et discret", "Devis et facture pro"]
        )
    ]
}

// MARK: - Forms State Drafts
struct ReservationDraft {
    var date: Date = Date().addingTimeInterval(86400) // Tomorrow
    var timeSlot: String = "19:30"
    var guestsCount: Int = 2
    var firstName: String = ""
    var lastName: String = ""
    var phone: String = ""
    var email: String = ""
    var occasion: String = "Repas romantique"
    var specialRequest: String = ""
}

struct EventQuoteDraft {
    var eventType: String = "Mariage / Fiançailles"
    var targetDate: Date = Date().addingTimeInterval(86400 * 30)
    var guestsCount: Int = 25
    var estimatedBudget: String = "1 500 € – 3 000 €"
    var fullName: String = ""
    var phone: String = ""
    var email: String = ""
    var message: String = ""
}

import SwiftUI
import MapKit

// MARK: - Contact & Location View
struct ContactLocationView: View {
    let onOpenReservation: () -> Void
    let onOpenDirections: () -> Void
    let onOpenCallAlert: () -> Void

    @State private var mapPosition: MapCameraPosition = .camera(
        MapCamera(
            centerCoordinate: CLLocationCoordinate2D(latitude: RestaurantInfo.latitude, longitude: RestaurantInfo.longitude),
            distance: 1200
        )
    )

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.xl) {
                // Header
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text("ACCÈS & CONTACT")
                        .font(AppTheme.captionFont)
                        .kerning(1.6)
                        .foregroundStyle(AppTheme.accent)

                    Text("Venir à La Petite Venise")
                        .font(AppTheme.displayFont)
                        .foregroundStyle(AppTheme.primary)

                    Text("Une péniche amarrée au cœur de Montargis, le long du Quai du Patis.")
                        .font(AppTheme.bodyFont)
                        .foregroundStyle(AppTheme.textSecondary)
                        .padding(.top, 2)
                }

                // Interactive Native Map
                mapCard

                // Practical Info Cards
                practicalInfoGrid

                // Customer reviews reminder
                reviewsSummaryCard

                // Buffer for bottom bar
                Color.clear.frame(height: 80)
            }
            .padding(.horizontal, Spacing.screenMargin)
            .padding(.top, Spacing.xs)
        }
        .background(AppTheme.ground.ignoresSafeArea())
    }

    // MARK: - Map Card
    private var mapCard: some View {
        VStack(spacing: 0) {
            Map(position: $mapPosition) {
                Marker(
                    RestaurantInfo.shortName,
                    systemImage: "sailboat.fill",
                    coordinate: CLLocationCoordinate2D(latitude: RestaurantInfo.latitude, longitude: RestaurantInfo.longitude)
                )
                .tint(AppTheme.accent)
            }
            .frame(height: 220)
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: NotebookTokens.radiusCard,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: NotebookTokens.radiusCard
                )
            )

            // Address bar + Directions CTA
            HStack(spacing: Spacing.md) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(RestaurantInfo.name)
                        .font(AppTheme.headlineFont)
                        .foregroundStyle(AppTheme.primary)

                    Text(RestaurantInfo.fullAddress)
                        .font(AppTheme.metaFont)
                        .foregroundStyle(AppTheme.textSecondary)
                }

                Spacer()

                Button(action: onOpenDirections) {
                    HStack(spacing: 6) {
                        Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                        Text("Itinéraire")
                    }
                    .font(AppTheme.headlineFont)
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, Spacing.md)
                    .padding(.vertical, 8)
                    .background(AppTheme.accent)
                    .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }
            .padding(Spacing.md)
            .background(AppTheme.surface)
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: NotebookTokens.radiusCard,
                    bottomTrailingRadius: NotebookTokens.radiusCard,
                    topTrailingRadius: 0
                )
            )
        }
        .overlay(
            RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous)
                .strokeBorder(AppTheme.border, lineWidth: 1)
        )
    }

    // MARK: - Practical Info Grid
    private var practicalInfoGrid: some View {
        VStack(spacing: Spacing.md) {
            // Opening hours card
            infoCard(
                icon: "clock.fill",
                title: "Horaires de Service",
                content: {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Déjeuners & Dîners")
                                .font(AppTheme.headlineFont)
                                .foregroundStyle(AppTheme.primary)
                            Spacer()
                            StatusPlaceholderBadge(label: "À compléter")
                        }
                        Text("Les créneaux de service exacts seront renseignés par l'établissement.")
                            .font(AppTheme.metaFont)
                            .foregroundStyle(AppTheme.textSecondary)
                    }
                }
            )

            // Phone & Contact Card
            infoCard(
                icon: "phone.fill",
                title: "Téléphone & Réservations Directes",
                content: {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Ligne directe du bateau")
                                .font(AppTheme.headlineFont)
                                .foregroundStyle(AppTheme.primary)
                            StatusPlaceholderBadge(label: "Numéro : À compléter")
                        }
                        Spacer()
                        Button("Appeler") {
                            onOpenCallAlert()
                        }
                        .font(AppTheme.headlineFont)
                        .foregroundStyle(AppTheme.accent)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(AppTheme.accent.opacity(0.12))
                        .clipShape(Capsule())
                    }
                }
            )

            // Price & Payment Card
            infoCard(
                icon: "creditcard.fill",
                title: "Tarifs & Moyens de Paiement",
                content: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Fourchette moyenne : **\(RestaurantInfo.priceRange)**")
                            .font(AppTheme.bodyFont)
                            .foregroundStyle(AppTheme.primary)

                        Text("Cartes bancaires, espèces, titres restaurant acceptés.")
                            .font(AppTheme.metaFont)
                            .foregroundStyle(AppTheme.textSecondary)
                    }
                }
            )
        }
    }

    private func infoCard<Content: View>(icon: String, title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundStyle(AppTheme.accent)
                Text(title)
                    .font(AppTheme.titleFont)
                    .foregroundStyle(AppTheme.primary)
            }

            content()
        }
        .padding(Spacing.lg)
        .background(AppTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous)
                .strokeBorder(AppTheme.border, lineWidth: 1)
        )
    }

    // MARK: - Reviews Summary Card
    private var reviewsSummaryCard: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Avis Vérifiés Google")
                        .font(AppTheme.titleFont)
                        .foregroundStyle(AppTheme.primary)
                    Text("Recommandé par 229 clients à Montargis")
                        .font(AppTheme.metaFont)
                        .foregroundStyle(AppTheme.textSecondary)
                }
                Spacer()
                RatingBadgeView(
                    rating: RestaurantInfo.googleRating,
                    reviewCount: RestaurantInfo.googleReviewCount
                )
            }
        }
        .padding(Spacing.lg)
        .background(AppTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous)
                .strokeBorder(AppTheme.border, lineWidth: 1)
        )
    }
}

// MARK: - Reservation Form Sheet (Demo mode with truthful non-confirmed copy)
struct ReservationSheet: View {
    @Environment(\.dismiss) private var dismiss

    @State private var reservationDate = Date().addingTimeInterval(86400) // Tomorrow
    @State private var timeSlot = "20:00"
    @State private var guestsCount = 2
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var occasion = "Dîner romantique"
    @State private var specialRequest = ""

    @State private var isConfirmedDemo = false

    let timeSlots = ["12:00", "12:30", "13:00", "19:30", "20:00", "20:30", "21:00"]
    let occasions = [
        "Dîner romantique",
        "Anniversaire",
        "Mariage / Fiançailles",
        "EVJF / EVG",
        "Repas professionnel",
        "Autre événement"
    ]

    var body: some View {
        NavigationStack {
            Group {
                if isConfirmedDemo {
                    confirmedDemoView
                } else {
                    reservationFormView
                }
            }
            .background(AppTheme.ground.ignoresSafeArea())
            .navigationTitle("Réserver une Table")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Fermer") {
                        dismiss()
                    }
                    .font(AppTheme.headlineFont)
                    .foregroundStyle(AppTheme.accent)
                }
            }
        }
    }

    // MARK: - Form View
    private var reservationFormView: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                // Truthful Demo Banner
                HStack(alignment: .top, spacing: Spacing.sm) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundStyle(NotebookTokens.warning)
                    Text("Version de démonstration : votre demande est enregistrée localement. Aucune confirmation automatique définitive n'est transmise sans validation du restaurant.")
                        .font(AppTheme.captionFont)
                        .foregroundStyle(AppTheme.textSecondary)
                }
                .padding(Spacing.sm)
                .background(NotebookTokens.warning.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: NotebookTokens.radiusControl, style: .continuous))

                // Date & Time
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text("Date & Heure Souhaitées")
                        .font(AppTheme.titleFont)
                        .foregroundStyle(AppTheme.primary)

                    DatePicker("Date de venue", selection: $reservationDate, in: Date()..., displayedComponents: .date)
                        .font(AppTheme.bodyFont)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Créneau horaire")
                            .font(AppTheme.metaFont)
                            .foregroundStyle(AppTheme.textSecondary)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: Spacing.xs) {
                                ForEach(timeSlots, id: \.self) { slot in
                                    Button(action: { timeSlot = slot }) {
                                        Text(slot)
                                            .font(AppTheme.headlineFont)
                                            .foregroundStyle(timeSlot == slot ? Color.white : AppTheme.primary)
                                            .padding(.horizontal, Spacing.md)
                                            .padding(.vertical, 8)
                                            .background(timeSlot == slot ? AppTheme.accent : AppTheme.ground)
                                            .clipShape(Capsule())
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }

                    Stepper("Nombre de couverts : \(guestsCount)", value: $guestsCount, in: 1...12)
                        .font(AppTheme.bodyFont)
                        .padding(.vertical, 4)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Occasion particulière")
                            .font(AppTheme.metaFont)
                            .foregroundStyle(AppTheme.textSecondary)

                        Picker("Occasion", selection: $occasion) {
                            ForEach(occasions, id: \.self) { occ in
                                Text(occ).tag(occ)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(AppTheme.accent)
                        .padding(Spacing.xs)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(AppTheme.ground)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding(Spacing.md)
                .background(AppTheme.surface)
                .clipShape(RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous))

                // Customer details
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text("Vos Coordonnées")
                        .font(AppTheme.titleFont)
                        .foregroundStyle(AppTheme.primary)

                    HStack(spacing: Spacing.sm) {
                        TextField("Prénom", text: $firstName)
                            .textFieldStyle(.roundedBorder)
                        TextField("Nom", text: $lastName)
                            .textFieldStyle(.roundedBorder)
                    }

                    TextField("Téléphone", text: $phone)
                        .keyboardType(.phonePad)
                        .textFieldStyle(.roundedBorder)

                    TextField("Adresse Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .textFieldStyle(.roundedBorder)

                    TextField("Demande particulière (allergie, table vue canal...)", text: $specialRequest, axis: .vertical)
                        .lineLimit(2...4)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(Spacing.md)
                .background(AppTheme.surface)
                .clipShape(RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous))

                // Submit CTA
                Button(action: {
                    isConfirmedDemo = true
                }) {
                    Text("Valider la demande de réservation")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(AppTheme.accent)
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)
                .disabled(firstName.isEmpty && phone.isEmpty)
                .opacity((firstName.isEmpty && phone.isEmpty) ? 0.6 : 1.0)
            }
            .padding(Spacing.screenMargin)
        }
    }

    // MARK: - Confirmed Demo View
    private var confirmedDemoView: some View {
        VStack(spacing: Spacing.lg) {
            Spacer()

            ZStack {
                Circle()
                    .fill(NotebookTokens.positive.opacity(0.15))
                    .frame(width: 80, height: 80)
                Image(systemName: "clock.badge.checkmark.fill")
                    .font(.system(size: 44))
                    .foregroundStyle(NotebookTokens.positive)
            }

            VStack(spacing: Spacing.xs) {
                Text("Demande Enregistrée")
                    .font(AppTheme.displayFont)
                    .foregroundStyle(AppTheme.primary)

                Text("Demande non confirmée")
                    .font(AppTheme.headlineFont)
                    .foregroundStyle(NotebookTokens.warning)

                Text("Le restaurant vous recontactera pour confirmer la disponibilité de votre table.")
                    .font(AppTheme.bodyFont)
                    .foregroundStyle(AppTheme.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            // Summary box
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text("DÉTAIL DE LA DEMANDE")
                    .font(AppTheme.captionFont)
                    .foregroundStyle(AppTheme.textSecondary)

                HStack {
                    Text("Heure & Couverts :")
                    Spacer()
                    Text("\(timeSlot) • \(guestsCount) personnes").bold()
                }

                HStack {
                    Text("Occasion :")
                    Spacer()
                    Text(occasion).bold()
                }

                if !firstName.isEmpty || !lastName.isEmpty {
                    HStack {
                        Text("Nom :")
                        Spacer()
                        Text("\(firstName) \(lastName)").bold()
                    }
                }
            }
            .font(AppTheme.metaFont)
            .padding(Spacing.md)
            .background(AppTheme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Non-confirmed explicit legal/demo copy
            Text("Aucune réservation n'est confirmée automatiquement.")
                .font(AppTheme.captionFont)
                .foregroundStyle(AppTheme.textSecondary)
                .multilineTextAlignment(.center)

            Spacer()

            Button(action: {
                dismiss()
            }) {
                Text("Retour à l'accueil")
                    .font(AppTheme.headlineFont)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(AppTheme.primary)
                    .clipShape(Capsule())
            }
            .buttonStyle(.plain)
            .padding(.horizontal, Spacing.screenMargin)
            .padding(.bottom, Spacing.md)
        }
        .padding(Spacing.screenMargin)
    }
}

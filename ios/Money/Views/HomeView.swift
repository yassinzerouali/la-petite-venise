import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: Int
    let onOpenReservation: () -> Void
    let onOpenDirections: () -> Void
    let onOpenQuote: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.xl) {
                // MARK: 1. Full Hero Banner
                heroSection

                // MARK: 2. Concept & Welcome section "Bienvenue à bord"
                conceptSection

                // MARK: 3. Menu Preview Showcase
                menuHighlightsSection

                // MARK: 4. Atmosphere & Gallery Teaser
                atmosphereSection

                // MARK: 5. Events & Privatisation teaser
                eventsTeaserSection

                // MARK: 6. Google Reviews Showcase
                reviewsSection

                // MARK: 7. Location & Practical Summary
                locationSummarySection

                // Spacing buffer for bottom quick action bar
                Color.clear.frame(height: 80)
            }
            .padding(.horizontal, Spacing.screenMargin)
            .padding(.top, Spacing.xs)
        }
        .background(AppTheme.ground.ignoresSafeArea())
    }

    // MARK: - Hero Section
    private var heroSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            // Editorial Hero Card
            ZStack(alignment: .bottomLeading) {
                // Venetian ambient dusk background
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                AppTheme.primary,
                                Color(red: 0.18, green: 0.28, blue: 0.36),
                                AppTheme.accent.opacity(0.85)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 380)
                    .overlay(
                        // Subtle wave pattern overlay
                        VStack {
                            HStack {
                                Spacer()
                                Image(systemName: "sailboat.fill")
                                    .font(.system(size: 140))
                                    .foregroundStyle(Color.white.opacity(0.06))
                                    .offset(x: 20, y: -20)
                            }
                            Spacer()
                        }
                    )

                // Foreground content
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    // Rating Pill
                    RatingBadgeView(
                        rating: RestaurantInfo.googleRating,
                        reviewCount: RestaurantInfo.googleReviewCount
                    )

                    // Title
                    Text("Bateau Restaurant\nLa Petite Venise")
                        .font(.system(size: 32, weight: .bold, design: .serif))
                        .foregroundStyle(Color.white)
                        .lineSpacing(4)
                        .padding(.top, 4)

                    // Subtitle
                    Text(RestaurantInfo.tagline)
                        .font(AppTheme.headlineFont)
                        .foregroundStyle(Color.white.opacity(0.9))
                        .lineLimit(3)

                    // Location tag
                    HStack(spacing: 6) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 12))
                        Text("Quai du Patis, Montargis")
                            .font(AppTheme.captionFont)
                    }
                    .foregroundStyle(Color.white.opacity(0.8))
                    .padding(.bottom, Spacing.xs)

                    // Dual CTAs
                    HStack(spacing: Spacing.sm) {
                        Button(action: onOpenReservation) {
                            HStack(spacing: 6) {
                                Image(systemName: "calendar.badge.plus")
                                Text("Réserver une table")
                            }
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 46)
                            .background(AppTheme.accent)
                            .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)

                        Button(action: { selectedTab = 1 }) {
                            Text("Découvrir le menu")
                                .font(AppTheme.headlineFont)
                                .foregroundStyle(Color.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 46)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule().strokeBorder(Color.white.opacity(0.3), lineWidth: 1)
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(Spacing.lg)
            }
        }
    }

    // MARK: - Concept Section "Bienvenue à bord"
    private var conceptSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            EditorialSectionHeader(
                kicker: "L'Expérience",
                title: "Bienvenue à bord",
                subtitle: "Une table d'exception amarrée sur les canaux de Montargis"
            )

            Text("Installé sur une péniche authentique Quai du Patis, le Bateau Restaurant **La Petite Venise** vous invite à une parenthèse gourmande et romantique au fil de l'eau. Notre cuisine française met à l'honneur les beaux produits de saison dans une atmosphère chaleureuse et feutrée.")
                .font(AppTheme.bodyFont)
                .foregroundStyle(AppTheme.text.opacity(0.9))
                .lineSpacing(5)

            // 3 feature highlights
            VStack(spacing: Spacing.sm) {
                featureRow(
                    icon: "water.waves",
                    title: "Cadre unique sur péniche",
                    description: "Dînez au fil de l'eau avec vue dégagée sur les reflets du canal de Montargis."
                )
                featureRow(
                    icon: "fork.knife",
                    title: "Cuisine française soignée",
                    description: "Poissons, viandes rôties et desserts gourmands aux saveurs du terroir du Gâtinais."
                )
                featureRow(
                    icon: "heart.fill",
                    title: "Ambiance romantique & familiale",
                    description: "Accueil souriant pour un tête-à-tête intime ou une célébration entourée de vos proches."
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

    private func featureRow(icon: String, title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: Spacing.md) {
            ZStack {
                Circle()
                    .fill(AppTheme.accent.opacity(0.12))
                    .frame(width: 36, height: 36)
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(AppTheme.accent)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(AppTheme.headlineFont)
                    .foregroundStyle(AppTheme.primary)
                Text(description)
                    .font(AppTheme.metaFont)
                    .foregroundStyle(AppTheme.textSecondary)
                    .lineLimit(2)
            }
            Spacer()
        }
        .padding(.vertical, 4)
    }

    // MARK: - Menu Highlights Section
    private var menuHighlightsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                EditorialSectionHeader(
                    kicker: "À la carte",
                    title: "Nos Plats Phares",
                    subtitle: "Une carte de saison entre 20 € et 70 €"
                )
                Spacer()
                Button("Tout voir") {
                    selectedTab = 1
                }
                .font(AppTheme.headlineFont)
                .foregroundStyle(AppTheme.accent)
            }

            // 3 preview items
            VStack(spacing: Spacing.sm) {
                ForEach(MenuDataStore.items.filter { $0.isChefSpecial }.prefix(3)) { item in
                    MenuItemRowCard(item: item, onTap: {
                        selectedTab = 1
                    })
                }
            }
        }
    }

    // MARK: - Atmosphere & Gallery Teaser
    private var atmosphereSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                EditorialSectionHeader(
                    kicker: "Galerie",
                    title: "L'Atmosphère du Bateau",
                    subtitle: "Lumières tamisées et décor soigné"
                )
                Spacer()
                Button("Galerie") {
                    selectedTab = 2
                }
                .font(AppTheme.headlineFont)
                .foregroundStyle(AppTheme.accent)
            }

            // Atmosphere preview cards
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Spacing.md) {
                    ForEach(GalleryDataStore.items.prefix(4)) { photo in
                        VStack(alignment: .leading, spacing: Spacing.xs) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(
                                        LinearGradient(
                                            colors: [AppTheme.primary, AppTheme.accent],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 200, height: 130)

                                Image(systemName: photo.systemSymbol)
                                    .font(.system(size: 38))
                                    .foregroundStyle(Color.white.opacity(0.85))
                            }

                            Text(photo.title)
                                .font(AppTheme.headlineFont)
                                .foregroundStyle(AppTheme.primary)
                                .lineLimit(1)

                            Text(photo.category.rawValue)
                                .font(AppTheme.captionFont)
                                .foregroundStyle(AppTheme.accent)
                        }
                        .frame(width: 200)
                    }
                }
            }
        }
    }

    // MARK: - Events Teaser Section
    private var eventsTeaserSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            EditorialSectionHeader(
                kicker: "Privatisation",
                title: "Vos Événements à Bord",
                subtitle: "Mariages, anniversaires, EVJF et repas d'affaires"
            )

            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous)
                    .fill(AppTheme.primary)
                    .frame(height: 190)

                VStack(alignment: .leading, spacing: Spacing.sm) {
                    HStack(spacing: 8) {
                        Image(systemName: "sparkles")
                            .foregroundStyle(AppTheme.accent)
                        Text("Offre sur-mesure")
                            .font(AppTheme.captionFont)
                            .foregroundStyle(Color.white.opacity(0.8))
                    }

                    Text("Privatisez la péniche pour vos plus beaux moments")
                        .font(AppTheme.titleFont)
                        .foregroundStyle(Color.white)
                        .lineLimit(2)

                    Text("Cocktails déjeunatoires, repas assis et animations au cœur de Montargis.")
                        .font(AppTheme.metaFont)
                        .foregroundStyle(Color.white.opacity(0.85))

                    Button(action: onOpenQuote) {
                        HStack(spacing: 6) {
                            Text("Demander un devis")
                            Image(systemName: "arrow.right")
                        }
                        .font(AppTheme.headlineFont)
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, Spacing.md)
                        .padding(.vertical, 8)
                        .background(AppTheme.accent)
                        .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                    .padding(.top, 4)
                }
                .padding(Spacing.md)
            }
        }
    }

    // MARK: - Google Reviews Section
    private var reviewsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            EditorialSectionHeader(
                kicker: "Avis Clients",
                title: "Ce qu'ils disent de nous",
                subtitle: "Note de 4,5/5 basée sur 229 avis Google"
            )

            VStack(spacing: Spacing.sm) {
                ForEach(ReviewDataStore.reviews) { review in
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        HStack {
                            Text(review.authorName)
                                .font(AppTheme.headlineFont)
                                .foregroundStyle(AppTheme.primary)

                            Spacer()

                            HStack(spacing: 2) {
                                ForEach(0..<5) { star in
                                    Image(systemName: Double(star) < review.rating ? "star.fill" : "star")
                                        .font(.system(size: 11))
                                        .foregroundStyle(Color(red: 0.88, green: 0.68, blue: 0.20))
                                }
                            }
                        }

                        HStack(spacing: 6) {
                            Text(review.tag)
                                .font(AppTheme.captionFont)
                                .foregroundStyle(AppTheme.accent)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(AppTheme.accent.opacity(0.12))
                                .clipShape(Capsule())

                            Text(review.dateText)
                                .font(AppTheme.captionFont)
                                .foregroundStyle(AppTheme.textSecondary)
                        }

                        Text("« \(review.comment) »")
                            .font(AppTheme.bodyFont)
                            .foregroundStyle(AppTheme.text.opacity(0.9))
                            .italic()
                            .padding(.top, 2)
                    }
                    .padding(Spacing.md)
                    .background(AppTheme.surface)
                    .clipShape(RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous)
                            .strokeBorder(AppTheme.border, lineWidth: 1)
                    )
                }
            }
        }
    }

    // MARK: - Practical Location Summary
    private var locationSummarySection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            EditorialSectionHeader(
                kicker: "Accès & Contact",
                title: "Nous Trouver",
                subtitle: "Amarré au Quai du Patis à Montargis"
            )

            VStack(alignment: .leading, spacing: Spacing.sm) {
                HStack(alignment: .top, spacing: Spacing.md) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(AppTheme.accent)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(RestaurantInfo.name)
                            .font(AppTheme.headlineFont)
                            .foregroundStyle(AppTheme.primary)
                        Text(RestaurantInfo.fullAddress)
                            .font(AppTheme.bodyFont)
                            .foregroundStyle(AppTheme.textSecondary)
                    }
                }

                Divider().overlay(AppTheme.border)

                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Horaires d'ouverture")
                            .font(AppTheme.metaFont)
                            .foregroundStyle(AppTheme.textSecondary)
                        StatusPlaceholderBadge(label: "Horaires : À compléter")
                    }
                    Spacer()
                    Button(action: onOpenDirections) {
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                            Text("Itinéraire")
                        }
                        .font(AppTheme.headlineFont)
                        .foregroundStyle(AppTheme.primary)
                        .padding(.horizontal, Spacing.md)
                        .padding(.vertical, 8)
                        .background(AppTheme.ground)
                        .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
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
}

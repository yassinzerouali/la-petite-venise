import SwiftUI

struct MenuView: View {
    @State private var selectedCategory: MenuCategory = .all
    @State private var selectedItemForDetail: MenuItem? = nil
    let onOpenReservation: () -> Void

    var filteredItems: [MenuItem] {
        if selectedCategory == .all {
            return MenuDataStore.items
        }
        return MenuDataStore.items.filter { $0.category == selectedCategory }
    }

    var body: some View {
        VStack(spacing: 0) {
            // MARK: Top Category Selector
            categoryRail
                .padding(.vertical, Spacing.xs)
                .background(AppTheme.ground)

            // MARK: Items List
            ScrollView {
                VStack(spacing: Spacing.lg) {
                    // Category intro card
                    categoryIntroBanner

                    // Menu items
                    VStack(spacing: Spacing.sm) {
                        ForEach(filteredItems) { item in
                            MenuItemRowCard(item: item) {
                                selectedItemForDetail = item
                            }
                        }
                    }

                    // Bottom info note
                    truthfulNoticeCard

                    // Buffer for bottom bar
                    Color.clear.frame(height: 80)
                }
                .padding(.horizontal, Spacing.screenMargin)
                .padding(.top, Spacing.sm)
            }
        }
        .background(AppTheme.ground.ignoresSafeArea())
        .sheet(item: $selectedItemForDetail) { item in
            MenuItemDetailSheet(item: item, onReserve: onOpenReservation)
        }
    }

    // MARK: - Category Filter Rail
    private var categoryRail: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.xs) {
                ForEach(MenuCategory.allCases) { category in
                    Button(action: {
                        selectedCategory = category
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: category.iconName)
                                .font(.system(size: 12))
                            Text(category.rawValue)
                                .font(AppTheme.headlineFont)
                        }
                        .foregroundStyle(selectedCategory == category ? NotebookTokens.inkOnAccent : AppTheme.primary)
                        .padding(.horizontal, Spacing.md)
                        .padding(.vertical, 8)
                        .background(selectedCategory == category ? AppTheme.accent : AppTheme.surface)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule().strokeBorder(selectedCategory == category ? Color.clear : AppTheme.border, lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, Spacing.screenMargin)
        }
    }

    // MARK: - Category Intro Banner
    private var categoryIntroBanner: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(selectedCategory == .all ? "La Carte Complète" : selectedCategory.rawValue)
                    .font(AppTheme.displayFont)
                    .foregroundStyle(AppTheme.primary)

                Text("Cuisine française de tradition et de saison • Quai du Patis")
                    .font(AppTheme.metaFont)
                    .foregroundStyle(AppTheme.textSecondary)
            }
            Spacer()
            Text("\(filteredItems.count) plats")
                .font(AppTheme.captionFont)
                .foregroundStyle(AppTheme.accent)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(AppTheme.accent.opacity(0.12))
                .clipShape(Capsule())
        }
        .padding(.vertical, Spacing.xs)
    }

    // MARK: - Truthful Notice Card
    private var truthfulNoticeCard: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            HStack(spacing: 6) {
                Image(systemName: "info.circle.fill")
                    .foregroundStyle(AppTheme.accent)
                Text("Information Menu & Prix")
                    .font(AppTheme.headlineFont)
                    .foregroundStyle(AppTheme.primary)
            }

            Text("Les plats et tarifs présentés sont indicatifs (fourchette 20 € à 70 € / pers.). Les mentions « À compléter » signalent les arrivages et spécialités du marché en attente de mise à jour par le chef.")
                .font(AppTheme.metaFont)
                .foregroundStyle(AppTheme.textSecondary)
                .lineSpacing(3)
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

// MARK: - Menu Item Detail Sheet
struct MenuItemDetailSheet: View {
    let item: MenuItem
    let onReserve: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.lg) {
                    // Header visual
                    ZStack(alignment: .bottomLeading) {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [AppTheme.primary, AppTheme.accent],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(height: 180)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.category.rawValue.uppercased())
                                .font(AppTheme.captionFont)
                                .kerning(1.5)
                                .foregroundStyle(Color.white.opacity(0.8))

                            Text(item.name)
                                .font(AppTheme.heroFont)
                                .foregroundStyle(Color.white)
                        }
                        .padding(Spacing.md)
                    }

                    // Price & Special status
                    HStack {
                        if item.isPlaceholder {
                            StatusPlaceholderBadge(label: "Prix : À compléter")
                        } else {
                            Text(item.formattedPrice)
                                .font(.system(size: 24, weight: .bold, design: .serif))
                                .foregroundStyle(AppTheme.accent)
                        }

                        Spacer()

                        if item.isChefSpecial {
                            HStack(spacing: 4) {
                                Image(systemName: "sparkles")
                                Text("Suggestion du Chef")
                            }
                            .font(AppTheme.metaFont)
                            .foregroundStyle(AppTheme.accent)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(AppTheme.accent.opacity(0.14))
                            .clipShape(Capsule())
                        }
                    }

                    // Description
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text("Description")
                            .font(AppTheme.titleFont)
                            .foregroundStyle(AppTheme.primary)

                        Text(item.descriptionText)
                            .font(AppTheme.bodyFont)
                            .foregroundStyle(AppTheme.text)
                            .lineSpacing(4)
                    }

                    // Dietary and Allergens
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text("Informations Régime & Allergènes")
                            .font(AppTheme.titleFont)
                            .foregroundStyle(AppTheme.primary)

                        HStack(spacing: Spacing.sm) {
                            if item.isVegetarian {
                                HStack(spacing: 4) {
                                    Image(systemName: "leaf.fill")
                                    Text("Plat végétarien")
                                }
                                .font(AppTheme.metaFont)
                                .foregroundStyle(NotebookTokens.positive)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(NotebookTokens.positive.opacity(0.12))
                                .clipShape(Capsule())
                            }

                            if item.allergens.isEmpty {
                                Text("Aucun allergène majeur signalé")
                                    .font(AppTheme.metaFont)
                                    .foregroundStyle(AppTheme.textSecondary)
                            } else {
                                ForEach(item.allergens, id: \.self) { allergen in
                                    Text(allergen)
                                        .font(AppTheme.metaFont)
                                        .foregroundStyle(AppTheme.textSecondary)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 6)
                                        .background(AppTheme.ground)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                    }

                    // CTA to book a table for this dish
                    Button(action: {
                        dismiss()
                        onReserve()
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "calendar.badge.plus")
                            Text("Réserver une table pour ce plat")
                        }
                        .font(AppTheme.headlineFont)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(AppTheme.accent)
                        .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                    .padding(.top, Spacing.md)
                }
                .padding(Spacing.lg)
            }
            .background(AppTheme.surface.ignoresSafeArea())
            .navigationTitle("Détail du Plat")
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
}

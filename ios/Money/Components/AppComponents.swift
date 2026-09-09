import SwiftUI

// MARK: - Rating Pill Component
struct RatingBadgeView: View {
    let rating: Double
    let reviewCount: Int

    var body: some View {
        HStack(spacing: Spacing.xs) {
            HStack(spacing: 3) {
                Image(systemName: "star.fill")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(Color(red: 0.88, green: 0.68, blue: 0.20)) // Gold star
                Text(String(format: "%.1f", rating))
                    .font(AppTheme.headlineFont)
                    .foregroundStyle(AppTheme.primary)
            }

            Text("•")
                .font(AppTheme.metaFont)
                .foregroundStyle(AppTheme.textSecondary)

            Text("\(reviewCount) avis Google")
                .font(AppTheme.metaFont)
                .foregroundStyle(AppTheme.textSecondary)
        }
        .padding(.horizontal, Spacing.sm)
        .padding(.vertical, 6)
        .background(AppTheme.surface)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .strokeBorder(AppTheme.border, lineWidth: 1)
        )
    }
}

// MARK: - Section Editorial Header
struct EditorialSectionHeader: View {
    let kicker: String?
    let title: String
    let subtitle: String?

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xxs) {
            if let kicker = kicker {
                Text(kicker.uppercased())
                    .font(AppTheme.captionFont)
                    .kerning(1.6)
                    .foregroundStyle(AppTheme.accent)
            }

            Text(title)
                .font(AppTheme.displayFont)
                .foregroundStyle(AppTheme.primary)

            if let subtitle = subtitle {
                Text(subtitle)
                    .font(AppTheme.bodyFont)
                    .foregroundStyle(AppTheme.textSecondary)
                    .padding(.top, 2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Status / 'À compléter' Pill
struct StatusPlaceholderBadge: View {
    var label: String = "À compléter"

    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(NotebookTokens.warning)
                .frame(width: 6, height: 6)
            Text(label)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(NotebookTokens.warning)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 3)
        .background(NotebookTokens.warning.opacity(0.12))
        .clipShape(Capsule())
    }
}

// MARK: - MenuItem Row Card
struct MenuItemRowCard: View {
    let item: MenuItem
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: Spacing.sm) {
                HStack(alignment: .top, spacing: Spacing.sm) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: Spacing.xs) {
                            Text(item.name)
                                .font(AppTheme.titleFont)
                                .foregroundStyle(AppTheme.primary)
                                .multilineTextAlignment(.leading)

                            if item.isChefSpecial {
                                Image(systemName: "sparkles")
                                    .font(.system(size: 12))
                                    .foregroundStyle(AppTheme.accent)
                            }
                        }

                        Text(item.descriptionText)
                            .font(AppTheme.bodyFont)
                            .foregroundStyle(AppTheme.text.opacity(0.85))
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                    }

                    Spacer(minLength: Spacing.xs)

                    VStack(alignment: .trailing, spacing: 4) {
                        if item.isPlaceholder {
                            StatusPlaceholderBadge()
                        } else {
                            Text(item.formattedPrice)
                                .font(.system(size: 17, weight: .bold, design: .serif))
                                .foregroundStyle(AppTheme.accent)
                        }
                    }
                }

                // Dietary and allergens footer
                if item.isVegetarian || !item.allergens.isEmpty {
                    HStack(spacing: Spacing.xs) {
                        if item.isVegetarian {
                            HStack(spacing: 3) {
                                Image(systemName: "leaf.fill")
                                    .font(.system(size: 10))
                                Text("Végétarien")
                                    .font(AppTheme.captionFont)
                            }
                            .foregroundStyle(NotebookTokens.positive)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(NotebookTokens.positive.opacity(0.12))
                            .clipShape(Capsule())
                        }

                        ForEach(item.allergens.prefix(2), id: \.self) { allergen in
                            Text(allergen)
                                .font(AppTheme.captionFont)
                                .foregroundStyle(AppTheme.textSecondary)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(AppTheme.ground)
                                .clipShape(Capsule())
                        }
                    }
                }
            }
            .padding(Spacing.md)
            .background(AppTheme.surface)
            .clipShape(RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous)
                    .strokeBorder(AppTheme.border, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Persistent Bottom Action Bar (Appeler | Itinéraire | Réserver)
struct QuickActionBarView: View {
    let onCall: () -> Void
    let onDirections: () -> Void
    let onReserve: () -> Void

    var body: some View {
        HStack(spacing: Spacing.sm) {
            // Call button
            Button(action: onCall) {
                HStack(spacing: 6) {
                    Image(systemName: "phone.fill")
                        .font(.system(size: 14, weight: .semibold))
                    Text("Appeler")
                        .font(AppTheme.headlineFont)
                }
                .foregroundStyle(AppTheme.primary)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(AppTheme.surface)
                .clipShape(Capsule())
                .overlay(
                    Capsule().strokeBorder(AppTheme.border, lineWidth: 1)
                )
            }
            .buttonStyle(.plain)

            // Directions button
            Button(action: onDirections) {
                HStack(spacing: 6) {
                    Image(systemName: "map.fill")
                        .font(.system(size: 14, weight: .semibold))
                    Text("Itinéraire")
                        .font(AppTheme.headlineFont)
                }
                .foregroundStyle(AppTheme.primary)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(AppTheme.surface)
                .clipShape(Capsule())
                .overlay(
                    Capsule().strokeBorder(AppTheme.border, lineWidth: 1)
                )
            }
            .buttonStyle(.plain)

            // Reserve CTA
            Button(action: onReserve) {
                HStack(spacing: 6) {
                    Image(systemName: "calendar.badge.plus")
                        .font(.system(size: 14, weight: .bold))
                    Text("Réserver")
                        .font(.system(size: 15, weight: .bold, design: .default))
                }
                .foregroundStyle(NotebookTokens.inkOnAccent)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(AppTheme.accent)
                .clipShape(Capsule())
                .shadow(color: AppTheme.accent.opacity(0.35), radius: 8, y: 3)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, Spacing.screenMargin)
        .padding(.top, Spacing.xs)
        .padding(.bottom, Spacing.sm)
        .background(
            Rectangle()
                .fill(AppTheme.ground.opacity(0.95))
                .ignoresSafeArea(edges: .bottom)
                .overlay(
                    Rectangle()
                        .fill(AppTheme.border)
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }
}

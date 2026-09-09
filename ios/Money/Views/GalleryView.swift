import SwiftUI

struct GalleryView: View {
    @State private var selectedCategory: GalleryCategory = .all
    @State private var selectedImageForFullscreen: GalleryImageItem? = nil

    var filteredItems: [GalleryImageItem] {
        if selectedCategory == .all {
            return GalleryDataStore.items
        }
        return GalleryDataStore.items.filter { $0.category == selectedCategory }
    }

    private let columns = [
        GridItem(.flexible(), spacing: Spacing.md),
        GridItem(.flexible(), spacing: Spacing.md)
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Category selector
            categoryFilterRail
                .padding(.vertical, Spacing.xs)
                .background(AppTheme.ground)

            // Gallery grid
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.lg) {
                    // Header text
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Galerie Photographique")
                            .font(AppTheme.displayFont)
                            .foregroundStyle(AppTheme.primary)

                        Text("Le bateau, les assiettes, les reflets et les moments d'exception")
                            .font(AppTheme.metaFont)
                            .foregroundStyle(AppTheme.textSecondary)
                    }
                    .padding(.top, Spacing.xs)

                    // 2-column Grid
                    LazyVGrid(columns: columns, spacing: Spacing.md) {
                        ForEach(filteredItems) { item in
                            galleryCard(for: item)
                                .onTapGesture {
                                    selectedImageForFullscreen = item
                                }
                        }
                    }

                    // Buffer for bottom bar
                    Color.clear.frame(height: 80)
                }
                .padding(.horizontal, Spacing.screenMargin)
            }
        }
        .background(AppTheme.ground.ignoresSafeArea())
        .fullScreenCover(item: $selectedImageForFullscreen) { item in
            FullscreenPhotoViewer(item: item)
        }
    }

    // MARK: - Category Filter Rail
    private var categoryFilterRail: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.xs) {
                ForEach(GalleryCategory.allCases) { category in
                    Button(action: {
                        selectedCategory = category
                    }) {
                        Text(category.rawValue)
                            .font(AppTheme.headlineFont)
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

    // MARK: - Gallery Grid Card
    private func galleryCard(for item: GalleryImageItem) -> some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            ZStack(alignment: .bottomTrailing) {
                RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [AppTheme.primary, AppTheme.accent.opacity(0.8)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 140)

                Image(systemName: item.systemSymbol)
                    .font(.system(size: 40))
                    .foregroundStyle(Color.white.opacity(0.9))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                // Fullscreen zoom indicator
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(Color.white)
                    .padding(6)
                    .background(Color.black.opacity(0.4))
                    .clipShape(Circle())
                    .padding(8)
            }

            Text(item.title)
                .font(AppTheme.headlineFont)
                .foregroundStyle(AppTheme.primary)
                .lineLimit(1)

            Text(item.category.rawValue)
                .font(AppTheme.captionFont)
                .foregroundStyle(AppTheme.accent)
        }
        .padding(Spacing.xs)
        .background(AppTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous)
                .strokeBorder(AppTheme.border, lineWidth: 1)
        )
    }
}

// MARK: - Fullscreen Photo Viewer Modal
struct FullscreenPhotoViewer: View {
    let item: GalleryImageItem
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                // Top close bar
                HStack {
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(Color.white.opacity(0.8))
                    }
                    .padding()
                }

                Spacer()

                // Large visual
                VStack(spacing: Spacing.lg) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [AppTheme.primary, AppTheme.accent],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(maxWidth: .infinity)
                            .frame(height: 320)
                            .padding(.horizontal, Spacing.screenMargin)

                        Image(systemName: item.systemSymbol)
                            .font(.system(size: 90))
                            .foregroundStyle(Color.white)
                    }

                    VStack(spacing: Spacing.xs) {
                        Text(item.category.rawValue.uppercased())
                            .font(AppTheme.captionFont)
                            .kerning(1.5)
                            .foregroundStyle(AppTheme.accent)

                        Text(item.title)
                            .font(AppTheme.heroFont)
                            .foregroundStyle(Color.white)

                        Text(item.description)
                            .font(AppTheme.bodyFont)
                            .foregroundStyle(Color.white.opacity(0.85))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, Spacing.xl)
                    }
                }

                Spacer()
            }
        }
    }
}

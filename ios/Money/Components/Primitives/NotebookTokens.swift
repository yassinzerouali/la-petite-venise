// 10x primitive: granola/design-tokens v1
import SwiftUI

/// Central design tokens for La Petite Venise (Granola editorial voice + Soir à Venise palette).
/// Primary: #22384A (Venice deep blue / primary ink)
/// Accent: #C56A4B (Terracotta / warm clay accent)
/// Ground: #F4ECDD (Warm cream paper)
/// Surface: #FBF6EC (Warm parchment surface)
/// Text: #211C16 (Deep warm ink)
@available(iOS 17.0, *)
enum NotebookTokens {
    // MARK: Grounds & surfaces (Soir à Venise palette)

    /// Ground: Warm cream paper `#F4ECDD`
    static let ground = Color(red: 0.957, green: 0.925, blue: 0.867)
    /// Surface: Warm parchment `#FBF6EC`
    static let surface = Color(red: 0.984, green: 0.965, blue: 0.925)
    /// Pure card white for contrast elements
    static let surfacePure = Color.white
    /// Surface warm: slightly deeper paper tone
    static let surfaceWarm = Color(red: 0.945, green: 0.910, blue: 0.850)
    /// Raised chip / control fill
    static let surfaceRaised = Color(red: 0.910, green: 0.875, blue: 0.810)

    // MARK: Ink & Palette

    /// Primary deep blue `#22384A` — used for brand highlights, deep text, hero contrasts
    static let primary = Color(red: 0.133, green: 0.220, blue: 0.290)
    /// Main reading text `#211C16` — deep warm ink
    static let ink = Color(red: 0.129, green: 0.110, blue: 0.086)
    /// Metadata, timestamps, captions, kickers — muted slate warm ink
    static let inkSecondary = Color(red: 0.420, green: 0.400, blue: 0.360)
    /// Content on accent- or primary-filled surfaces
    static let inkOnAccent = Color.white

    // MARK: Accent & semantics

    /// Terracotta accent `#C56A4B` — signature CTA, highlights, romantic warm glow
    static let accent = Color(red: 0.773, green: 0.416, blue: 0.294)
    /// Terracotta at 14%
    static let accentSoft = accent.opacity(0.14)
    /// Muted water blue
    static let waterBlue = Color(red: 0.220, green: 0.380, blue: 0.480)
    /// Confirmations & live
    static let positive = Color(red: 0.260, green: 0.500, blue: 0.320)
    /// Caution & pending
    static let warning = Color(red: 0.750, green: 0.520, blue: 0.180)
    /// Destructive / alerts
    static let negative = Color(red: 0.720, green: 0.280, blue: 0.240)

    /// Hairline separators on paper
    static let hairline = ink.opacity(0.10)

    // MARK: Radii

    static let radiusCard: CGFloat = 14
    static let radiusControl: CGFloat = 10
    static let radiusPill: CGFloat = 24

    // MARK: Type

    /// Serif display for titles (hero, document headings)
    static func display(_ size: CGFloat) -> Font {
        .system(size: size, weight: .bold, design: .serif)
    }
    /// Serif section titles
    static let titleFont: Font = .system(.title3, design: .serif, weight: .semibold)
    /// Sans headline for subtitles & emphasis
    static let headlineFont: Font = .system(.subheadline, design: .default, weight: .semibold)
    /// Sans body for reading
    static let bodyFont: Font = .system(.body, design: .default)
    /// Sans metadata
    static let metaFont: Font = .system(.footnote, design: .default, weight: .medium)
    /// Sans caption
    static let captionFont: Font = .system(.caption2, design: .default, weight: .semibold)
}

/// App-level theme mapping & Spacing grid constants
enum AppTheme {
    static let displayFont = NotebookTokens.display(28)
    static let heroFont = NotebookTokens.display(34)
    static let titleFont = NotebookTokens.titleFont
    static let headlineFont = NotebookTokens.headlineFont
    static let bodyFont = NotebookTokens.bodyFont
    static let metaFont = NotebookTokens.metaFont
    static let captionFont = NotebookTokens.captionFont

    static let primary = NotebookTokens.primary
    static let accent = NotebookTokens.accent
    static let ground = NotebookTokens.ground
    static let surface = NotebookTokens.surface
    static let text = NotebookTokens.ink
    static let textSecondary = NotebookTokens.inkSecondary
    static let border = NotebookTokens.hairline
}

enum Spacing {
    static let xxs: CGFloat = 4
    static let xs: CGFloat = 8
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let lg: CGFloat = 20
    static let xl: CGFloat = 24
    static let xxl: CGFloat = 32
    static let huge: CGFloat = 48
    static let screenMargin: CGFloat = 16
}

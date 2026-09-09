import SwiftUI

struct EventsView: View {
    @State private var showingQuoteSheet = false
    @State private var selectedPackageForQuote: EventPackageItem? = nil

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.xl) {
                // Header
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text("PRIVATISATION & RÉCEPTIONS")
                        .font(AppTheme.captionFont)
                        .kerning(1.6)
                        .foregroundStyle(AppTheme.accent)

                    Text("Vos Événements à Bord")
                        .font(AppTheme.displayFont)
                        .foregroundStyle(AppTheme.primary)

                    Text("Une péniche chaleureuse amarrée Quai du Patis pour accueillir vos plus beaux moments : mariages, anniversaires, EVJF/EVG et repas d'affaires.")
                        .font(AppTheme.bodyFont)
                        .foregroundStyle(AppTheme.textSecondary)
                        .padding(.top, 2)
                }

                // CTA Banner to request a quote
                ctaQuoteBanner

                // Event packages list
                VStack(spacing: Spacing.md) {
                    ForEach(EventsDataStore.packages) { pkg in
                        eventPackageCard(pkg)
                    }
                }

                // Bottom reassurance card
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    HStack(spacing: 6) {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(AppTheme.accent)
                        Text("Accompagnement Personnalisé")
                            .font(AppTheme.headlineFont)
                            .foregroundStyle(AppTheme.primary)
                    }

                    Text("Chaque demande fait l'objet d'un échange direct avec le restaurant afin d'adapter le menu, les accords mets & vins et l'agencement du bateau à votre événement.")
                        .font(AppTheme.metaFont)
                        .foregroundStyle(AppTheme.textSecondary)
                }
                .padding(Spacing.md)
                .background(AppTheme.surface)
                .clipShape(RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous)
                        .strokeBorder(AppTheme.border, lineWidth: 1)
                )

                // Buffer for bottom bar
                Color.clear.frame(height: 80)
            }
            .padding(.horizontal, Spacing.screenMargin)
            .padding(.top, Spacing.xs)
        }
        .background(AppTheme.ground.ignoresSafeArea())
        .sheet(isPresented: $showingQuoteSheet) {
            QuoteFormSheet(preselectedPackage: selectedPackageForQuote)
        }
    }

    // MARK: - Banner
    private var ctaQuoteBanner: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [AppTheme.primary, Color(red: 0.18, green: 0.30, blue: 0.38)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 150)

            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text("Privatisation complète ou partielle")
                    .font(AppTheme.titleFont)
                    .foregroundStyle(Color.white)

                Text("Recevez une proposition détaillée sous 48h.")
                    .font(AppTheme.metaFont)
                    .foregroundStyle(Color.white.opacity(0.85))

                Button(action: {
                    selectedPackageForQuote = nil
                    showingQuoteSheet = true
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "pencil.and.list.clipboard")
                        Text("Demander un devis sur-mesure")
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

    // MARK: - Package Card
    private func eventPackageCard(_ pkg: EventPackageItem) -> some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack(alignment: .top) {
                ZStack {
                    Circle()
                        .fill(AppTheme.accent.opacity(0.12))
                        .frame(width: 42, height: 42)
                    Image(systemName: pkg.iconName)
                        .font(.system(size: 20))
                        .foregroundStyle(AppTheme.accent)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(pkg.title)
                        .font(AppTheme.titleFont)
                        .foregroundStyle(AppTheme.primary)

                    Text(pkg.subtitle)
                        .font(AppTheme.metaFont)
                        .foregroundStyle(AppTheme.textSecondary)
                }

                Spacer()

                Text(pkg.capacityText)
                    .font(AppTheme.captionFont)
                    .foregroundStyle(AppTheme.accent)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(AppTheme.ground)
                    .clipShape(Capsule())
            }

            Text(pkg.descriptionText)
                .font(AppTheme.bodyFont)
                .foregroundStyle(AppTheme.text.opacity(0.9))
                .lineSpacing(3)

            // Highlights
            VStack(alignment: .leading, spacing: 4) {
                ForEach(pkg.highlights, id: \.self) { hl in
                    HStack(spacing: 6) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(NotebookTokens.positive)
                        Text(hl)
                            .font(AppTheme.metaFont)
                            .foregroundStyle(AppTheme.textSecondary)
                    }
                }
            }

            Divider().overlay(AppTheme.border)

            // Button to trigger quote for this package
            Button(action: {
                selectedPackageForQuote = pkg
                showingQuoteSheet = true
            }) {
                HStack {
                    Text("Devis pour cet événement")
                        .font(AppTheme.headlineFont)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .bold))
                }
                .foregroundStyle(AppTheme.accent)
            }
            .buttonStyle(.plain)
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

// MARK: - Quote Form Sheet (Demo mode with truthful non-confirmed copy)
struct QuoteFormSheet: View {
    var preselectedPackage: EventPackageItem?
    @Environment(\.dismiss) private var dismiss

    @State private var eventType: String = "Mariage / Fiançailles"
    @State private var targetDate: Date = Date().addingTimeInterval(86400 * 30)
    @State private var guestsCount: Int = 25
    @State private var estimatedBudget: String = "1 500 € – 3 000 €"
    @State private var fullName: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var message: String = ""

    @State private var isSubmitted = false

    let eventTypes = [
        "Mariage / Fiançailles",
        "Anniversaire",
        "EVJF / EVG",
        "Dîner romantique spécial",
        "Repas professionnel / Séminaire",
        "Privatisation totale"
    ]

    let budgetOptions = [
        "< 1 000 €",
        "1 000 € – 2 500 €",
        "2 500 € – 5 000 €",
        "> 5 000 €",
        "À définir ensemble"
    ]

    var body: some View {
        NavigationStack {
            Group {
                if isSubmitted {
                    submittedStateView
                } else {
                    formContentView
                }
            }
            .background(AppTheme.ground.ignoresSafeArea())
            .navigationTitle("Demande de Devis")
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
            .onAppear {
                if let pkg = preselectedPackage {
                    eventType = pkg.title
                }
            }
        }
    }

    // MARK: Form Content
    private var formContentView: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                // Truthful capability disclosure banner
                HStack(alignment: .top, spacing: Spacing.sm) {
                    Image(systemName: "info.circle.fill")
                        .foregroundStyle(NotebookTokens.warning)
                    Text("Cette demande est enregistrée localement en version démo. En production, elle sera transmise directement au gérant du Bateau Restaurant La Petite Venise.")
                        .font(AppTheme.captionFont)
                        .foregroundStyle(AppTheme.textSecondary)
                }
                .padding(Spacing.sm)
                .background(NotebookTokens.warning.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: NotebookTokens.radiusControl, style: .continuous))

                // Section 1: Event Details
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text("Votre Projet d'Événement")
                        .font(AppTheme.titleFont)
                        .foregroundStyle(AppTheme.primary)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Type d'événement")
                            .font(AppTheme.metaFont)
                            .foregroundStyle(AppTheme.textSecondary)

                        Picker("Type d'événement", selection: $eventType) {
                            ForEach(eventTypes, id: \.self) { type in
                                Text(type).tag(type)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(AppTheme.accent)
                        .padding(Spacing.xs)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(AppTheme.surface)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }

                    DatePicker("Date souhaitée", selection: $targetDate, in: Date()..., displayedComponents: .date)
                        .font(AppTheme.bodyFont)
                        .foregroundStyle(AppTheme.text)
                        .padding(.vertical, 4)

                    Stepper("Nombre de convives : \(guestsCount)", value: $guestsCount, in: 2...100)
                        .font(AppTheme.bodyFont)
                        .foregroundStyle(AppTheme.text)
                        .padding(.vertical, 4)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Budget approximatif")
                            .font(AppTheme.metaFont)
                            .foregroundStyle(AppTheme.textSecondary)

                        Picker("Budget estimé", selection: $estimatedBudget) {
                            ForEach(budgetOptions, id: \.self) { b in
                                Text(b).tag(b)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(AppTheme.accent)
                        .padding(Spacing.xs)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(AppTheme.surface)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding(Spacing.md)
                .background(AppTheme.surface)
                .clipShape(RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous))

                // Section 2: Contact
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text("Vos Coordonnées")
                        .font(AppTheme.titleFont)
                        .foregroundStyle(AppTheme.primary)

                    TextField("Nom & Prénom", text: $fullName)
                        .textFieldStyle(.roundedBorder)

                    TextField("Téléphone", text: $phone)
                        .keyboardType(.phonePad)
                        .textFieldStyle(.roundedBorder)

                    TextField("Adresse Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .textFieldStyle(.roundedBorder)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Précisions sur votre demande (optionnel)")
                            .font(AppTheme.metaFont)
                            .foregroundStyle(AppTheme.textSecondary)

                        TextField("Ex : Menu spécifique, décoration souhaitée...", text: $message, axis: .vertical)
                            .lineLimit(3...5)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                .padding(Spacing.md)
                .background(AppTheme.surface)
                .clipShape(RoundedRectangle(cornerRadius: NotebookTokens.radiusCard, style: .continuous))

                // Submit button
                Button(action: {
                    isSubmitted = true
                }) {
                    Text("Envoyer ma demande de devis")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(AppTheme.accent)
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)
                .disabled(fullName.isEmpty && phone.isEmpty && email.isEmpty)
                .opacity((fullName.isEmpty && phone.isEmpty && email.isEmpty) ? 0.6 : 1.0)
            }
            .padding(Spacing.screenMargin)
        }
    }

    // MARK: Submitted State (Disclosed Demo)
    private var submittedStateView: some View {
        VStack(spacing: Spacing.lg) {
            Spacer()

            ZStack {
                Circle()
                    .fill(NotebookTokens.positive.opacity(0.15))
                    .frame(width: 80, height: 80)
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(NotebookTokens.positive)
            }

            VStack(spacing: Spacing.xs) {
                Text("Demande de Devis Enregistrée")
                    .font(AppTheme.displayFont)
                    .foregroundStyle(AppTheme.primary)
                    .multilineTextAlignment(.center)

                Text("Le restaurant vous recontactera.")
                    .font(AppTheme.headlineFont)
                    .foregroundStyle(AppTheme.accent)
            }

            // Summary box
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text("RÉCAPITULATIF PROVISOIRE")
                    .font(AppTheme.captionFont)
                    .foregroundStyle(AppTheme.textSecondary)

                HStack {
                    Text("Événement :")
                    Spacer()
                    Text(eventType).bold()
                }
                HStack {
                    Text("Convives :")
                    Spacer()
                    Text("\(guestsCount) personnes").bold()
                }
                HStack {
                    Text("Budget :")
                    Spacer()
                    Text(estimatedBudget).bold()
                }
            }
            .font(AppTheme.metaFont)
            .padding(Spacing.md)
            .background(AppTheme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Disclosure note
            Text("ℹ️ Mode démo : Aucune confirmation automatique n'est transmise tant qu'aucun backend n'est relié.")
                .font(AppTheme.captionFont)
                .foregroundStyle(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            Button(action: {
                dismiss()
            }) {
                Text("Terminer")
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

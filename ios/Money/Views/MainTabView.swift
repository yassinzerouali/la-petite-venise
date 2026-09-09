import SwiftUI
import UIKit

struct MainTabView: View {
    @State private var selectedTab: Int = 0
    @State private var showingReservationSheet = false
    @State private var showingQuoteSheet = false
    @State private var showingCallPlaceholderAlert = false

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                // Tab 0: Accueil
                NavigationStack {
                    HomeView(
                        selectedTab: $selectedTab,
                        onOpenReservation: { showingReservationSheet = true },
                        onOpenDirections: openAppleMapsDirections,
                        onOpenQuote: { showingQuoteSheet = true }
                    )
                    .navigationTitle(RestaurantInfo.shortName)
                    .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Accueil", systemImage: "sailboat.fill")
                }
                .tag(0)

                // Tab 1: Menu
                NavigationStack {
                    MenuView(
                        onOpenReservation: { showingReservationSheet = true }
                    )
                    .navigationTitle("La Carte")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Menu", systemImage: "fork.knife")
                }
                .tag(1)

                // Tab 2: Galerie
                NavigationStack {
                    GalleryView()
                        .navigationTitle("Galerie")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Galerie", systemImage: "photo.on.rectangle.angled")
                }
                .tag(2)

                // Tab 3: Événements
                NavigationStack {
                    EventsView()
                        .navigationTitle("Événements")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Événements", systemImage: "sparkles")
                }
                .tag(3)

                // Tab 4: Accès & Contact
                NavigationStack {
                    ContactLocationView(
                        onOpenReservation: { showingReservationSheet = true },
                        onOpenDirections: openAppleMapsDirections,
                        onOpenCallAlert: { showingCallPlaceholderAlert = true }
                    )
                    .navigationTitle("Accès")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Accès", systemImage: "mappin.and.ellipse")
                }
                .tag(4)
            }
            .tint(AppTheme.accent)

            // MARK: - Persistent Bottom Quick Action Bar
            QuickActionBarView(
                onCall: { showingCallPlaceholderAlert = true },
                onDirections: openAppleMapsDirections,
                onReserve: { showingReservationSheet = true }
            )
            .padding(.bottom, 48) // Sits above default tab bar
        }
        .sheet(isPresented: $showingReservationSheet) {
            ReservationSheet()
        }
        .sheet(isPresented: $showingQuoteSheet) {
            QuoteFormSheet()
        }
        .alert("Téléphone — À compléter", isPresented: $showingCallPlaceholderAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Le numéro direct de la péniche n'a pas encore été renseigné par l'établissement. Vous pouvez formuler votre demande via le bouton Réserver.")
        }
    }

    // MARK: - Native Apple Maps Directions Opener
    private func openAppleMapsDirections() {
        let lat = RestaurantInfo.latitude
        let lon = RestaurantInfo.longitude
        let name = "Bateau Restaurant La Petite Venise, Montargis"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "La+Petite+Venise"
        let urlString = "http://maps.apple.com/?daddr=\(lat),\(lon)&q=\(name)"
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}

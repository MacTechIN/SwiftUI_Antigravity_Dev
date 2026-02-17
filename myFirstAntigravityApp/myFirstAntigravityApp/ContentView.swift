import SwiftUI

struct ContentView: View {
    @State private var isWaving = false
    @State private var navigateToDashboard = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    // Animated Icon
                    Image(systemName: "hand.wave.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.blue)
                        .rotationEffect(.degrees(isWaving ? 20 : -20))
                        .animation(
                            .easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                            value: isWaving
                        )
                    
                    VStack(spacing: 12) {
                        Text("반가워요, Sam!")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                        
                        Text("우리의 첫 번째 항해를 시작할 준비가 되셨나요?")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer()
                    
                    // Start Button with Navigation
                    Button(action: {
                        navigateToDashboard = true
                    }) {
                        HStack {
                            Text("시작하기")
                                .fontWeight(.semibold)
                            Image(systemName: "chevron.right")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.cyan]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(15)
                        .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 30)
                }
                .padding()
            }
            .onAppear {
                isWaving = true
            }
            .navigationDestination(isPresented: $navigateToDashboard) {
                MainDashboardView()
            }
        }
    }
}

#Preview {
    ContentView()
}

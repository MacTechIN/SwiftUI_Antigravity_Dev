import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // 배경색 설정
            Color.blue.opacity(0.1).ignoresSafeArea()
            
            VStack(spacing: 20) {
                // 아이콘
                Image(systemName: "hand.wave.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                // 메인 타이틀
                Text("반가워요, 대표님!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // 서브 타이틀
                Text("아론과 함께 만드는 첫 번째 앱입니다.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // 버튼
                Button(action: {
                    print("버튼이 눌렸습니다!")
                }) {
                    Text("시작하기")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

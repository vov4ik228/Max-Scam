import SwiftUI
import AVKit

struct FullScreenVideoView: UIViewControllerRepresentable {
    let player: AVQueuePlayer
    private var looper: AVPlayerLooper?

    init(url: URL) {
        let queuePlayer = AVQueuePlayer()
        let item = AVPlayerItem(url: url)
        self.player = queuePlayer
        self.looper = AVPlayerLooper(player: queuePlayer, templateItem: item)
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false      // 🔒 скрываем управление
        controller.videoGravity = .resizeAspectFill  // видео на весь экран
        player.isMuted = true                         // звук отключен
        player.play()
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}

struct ContentView: View {
    @State private var showAlert = false

    var body: some View {
        ZStack {
            if let url = Bundle.main.url(forResource: "errr", withExtension: "mp4") {
                FullScreenVideoView(url: url)
                    .ignoresSafeArea()

                // прозрачный слой, блокирующий все касания
                Color.clear
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
            }
        }
        .onAppear {
            // Устанавливаем таймер для показа предупреждения через 10 секунд
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Предупреждение"),
                message: Text("приложение не поддерживается вашим устройством"),
                dismissButton: .default(Text("OK"), action: {
                    exit(0) // ⚠️ только для теста
                })
            )
        }
    }
}

#Preview {
    ContentView()
}

import SpriteKit

protocol MatchSceneDelegate: AnyObject {
    func matchScene(_ scene: MatchScene, didUpdateMinute minute: Int)
    func matchSceneDidFinish(_ scene: MatchScene)
}

final class MatchScene: SKScene {

    weak var matchDelegate: MatchSceneDelegate?

    private let homeTeam: Team
    private let awayTeam: Team

    private var ball: SKShapeNode!
    private var homePlayers: [SKShapeNode] = []
    private var awayPlayers: [SKShapeNode] = []
    private var homeBasePositions: [CGPoint] = []
    private var awayBasePositions: [CGPoint] = []

    private var currentMinute = 0
    private var isSimulating = false
    private var simulationTimer: Timer?

    private var fieldRect: CGRect = .zero
    private let padding: CGFloat = 16
    private let playerRadius: CGFloat = 10
    private let ballRadius: CGFloat = 6

    private(set) var resolvedHomeColor: SKColor = .blue
    private(set) var resolvedAwayColor: SKColor = .white

    var resolvedHomeUIColor: UIColor { UIColor(cgColor: resolvedHomeColor.cgColor) }
    var resolvedAwayUIColor: UIColor { UIColor(cgColor: resolvedAwayColor.cgColor) }

    private var ballCarrier: SKShapeNode?
    private var isHomePossession = true
    private let ballOffset: CGFloat = 14

    init(size: CGSize, homeTeam: Team, awayTeam: Team) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        super.init(size: size)
        resolveColors()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        removeAllChildren()
        homePlayers.removeAll()
        awayPlayers.removeAll()
        backgroundColor = SKColor(red: 0.13, green: 0.55, blue: 0.13, alpha: 1.0)
        fieldRect = CGRect(x: padding, y: padding, width: size.width - padding * 2, height: size.height - padding * 2)
        drawField()
        placePlayers()
        placeBall()
    }

    override func didChangeSize(_ oldSize: CGSize) {
        guard size.width > 0, size.height > 0, oldSize != size else { return }
        removeAllChildren()
        homePlayers.removeAll()
        awayPlayers.removeAll()
        fieldRect = CGRect(x: padding, y: padding, width: size.width - padding * 2, height: size.height - padding * 2)
        drawField()
        placePlayers()
        placeBall()
    }

    private func resolveColors() {
        let hc = SKColor(cgColor: homeTeam.primaryColor.cgColor)
        var ac = SKColor(cgColor: awayTeam.primaryColor.cgColor)

        var hr: CGFloat = 0, hg: CGFloat = 0, hb: CGFloat = 0
        var ar: CGFloat = 0, ag: CGFloat = 0, ab: CGFloat = 0
        hc.getRed(&hr, green: &hg, blue: &hb, alpha: nil)
        ac.getRed(&ar, green: &ag, blue: &ab, alpha: nil)

        let diff = abs(hr - ar) + abs(hg - ag) + abs(hb - ab)
        if diff < 0.4 {
            ac = SKColor(cgColor: awayTeam.secondaryColor.cgColor)
            ac.getRed(&ar, green: &ag, blue: &ab, alpha: nil)
            let diff2 = abs(hr - ar) + abs(hg - ag) + abs(hb - ab)
            if diff2 < 0.4 {
                ac = SKColor.cyan
            }
        }

        let greenDiff = abs(hr - 0.13) + abs(hg - 0.55) + abs(hb - 0.13)
        if greenDiff < 0.5 {
            resolvedHomeColor = SKColor(red: 0.2, green: 0.2, blue: 0.8, alpha: 1)
        } else {
            resolvedHomeColor = hc
        }

        let greenDiff2 = abs(ar - 0.13) + abs(ag - 0.55) + abs(ab - 0.13)
        if greenDiff2 < 0.5 {
            resolvedAwayColor = SKColor.white
        } else {
            resolvedAwayColor = ac
        }
    }

    private func drawField() {
        let fw = fieldRect.width
        let fh = fieldRect.height
        let ox = fieldRect.origin.x
        let oy = fieldRect.origin.y
        let cx = ox + fw / 2
        let cy = oy + fh / 2

        let outline = SKShapeNode(rect: fieldRect, cornerRadius: 2)
        outline.strokeColor = SKColor(white: 1, alpha: 0.8)
        outline.lineWidth = 2
        outline.fillColor = .clear
        addChild(outline)

        let halfPath = CGMutablePath()
        halfPath.move(to: CGPoint(x: ox, y: cy))
        halfPath.addLine(to: CGPoint(x: ox + fw, y: cy))
        let halfLine = SKShapeNode(path: halfPath)
        halfLine.strokeColor = SKColor(white: 1, alpha: 0.8)
        halfLine.lineWidth = 2
        addChild(halfLine)

        let circleR = min(fw, fh) * 0.12
        let centerCircle = SKShapeNode(circleOfRadius: circleR)
        centerCircle.position = CGPoint(x: cx, y: cy)
        centerCircle.strokeColor = SKColor(white: 1, alpha: 0.8)
        centerCircle.lineWidth = 2
        centerCircle.fillColor = .clear
        addChild(centerCircle)

        let centerDot = SKShapeNode(circleOfRadius: 3)
        centerDot.position = CGPoint(x: cx, y: cy)
        centerDot.fillColor = .white
        addChild(centerDot)

        let penW = fw * 0.4
        let penH = fh * 0.16
        let bottomPen = SKShapeNode(rect: CGRect(x: cx - penW / 2, y: oy, width: penW, height: penH))
        bottomPen.strokeColor = SKColor(white: 1, alpha: 0.8)
        bottomPen.lineWidth = 2
        bottomPen.fillColor = .clear
        addChild(bottomPen)

        let topPen = SKShapeNode(rect: CGRect(x: cx - penW / 2, y: oy + fh - penH, width: penW, height: penH))
        topPen.strokeColor = SKColor(white: 1, alpha: 0.8)
        topPen.lineWidth = 2
        topPen.fillColor = .clear
        addChild(topPen)

        let goalW = fw * 0.2
        let goalH: CGFloat = 6
        let bottomGoal = SKShapeNode(rect: CGRect(x: cx - goalW / 2, y: oy - goalH, width: goalW, height: goalH))
        bottomGoal.fillColor = .white
        bottomGoal.strokeColor = .white
        addChild(bottomGoal)

        let topGoal = SKShapeNode(rect: CGRect(x: cx - goalW / 2, y: oy + fh, width: goalW, height: goalH))
        topGoal.fillColor = .white
        topGoal.strokeColor = .white
        addChild(topGoal)

        let smallPenW = fw * 0.18
        let smallPenH = fh * 0.06
        let bottomSmall = SKShapeNode(rect: CGRect(x: cx - smallPenW / 2, y: oy, width: smallPenW, height: smallPenH))
        bottomSmall.strokeColor = SKColor(white: 1, alpha: 0.6)
        bottomSmall.lineWidth = 1.5
        bottomSmall.fillColor = .clear
        addChild(bottomSmall)

        let topSmall = SKShapeNode(rect: CGRect(x: cx - smallPenW / 2, y: oy + fh - smallPenH, width: smallPenW, height: smallPenH))
        topSmall.strokeColor = SKColor(white: 1, alpha: 0.6)
        topSmall.lineWidth = 1.5
        topSmall.fillColor = .clear
        addChild(topSmall)

        let cornerR: CGFloat = 8
        let corners: [(CGPoint, CGFloat, CGFloat)] = [
            (CGPoint(x: ox, y: oy), 0, .pi / 2),
            (CGPoint(x: ox + fw, y: oy), .pi / 2, .pi),
            (CGPoint(x: ox + fw, y: oy + fh), .pi, 3 * .pi / 2),
            (CGPoint(x: ox, y: oy + fh), 3 * .pi / 2, 2 * .pi)
        ]
        for (center, start, end) in corners {
            let arcPath = CGMutablePath()
            arcPath.addArc(center: center, radius: cornerR, startAngle: start, endAngle: end, clockwise: false)
            let arc = SKShapeNode(path: arcPath)
            arc.strokeColor = SKColor(white: 1, alpha: 0.6)
            arc.lineWidth = 1.5
            addChild(arc)
        }
    }

    private func placePlayers() {
        let fw = fieldRect.width
        let fh = fieldRect.height
        let ox = fieldRect.origin.x
        let oy = fieldRect.origin.y
        let cx = ox + fw / 2

        homeBasePositions = [
            CGPoint(x: cx, y: oy + fh * 0.05),
            CGPoint(x: cx - fw * 0.3, y: oy + fh * 0.15),
            CGPoint(x: cx - fw * 0.1, y: oy + fh * 0.15),
            CGPoint(x: cx + fw * 0.1, y: oy + fh * 0.15),
            CGPoint(x: cx + fw * 0.3, y: oy + fh * 0.15),
            CGPoint(x: cx - fw * 0.25, y: oy + fh * 0.28),
            CGPoint(x: cx, y: oy + fh * 0.28),
            CGPoint(x: cx + fw * 0.25, y: oy + fh * 0.28),
            CGPoint(x: cx - fw * 0.2, y: oy + fh * 0.38),
            CGPoint(x: cx + fw * 0.2, y: oy + fh * 0.38),
            CGPoint(x: cx, y: oy + fh * 0.42)
        ]

        awayBasePositions = [
            CGPoint(x: cx, y: oy + fh * 0.95),
            CGPoint(x: cx - fw * 0.3, y: oy + fh * 0.85),
            CGPoint(x: cx - fw * 0.1, y: oy + fh * 0.85),
            CGPoint(x: cx + fw * 0.1, y: oy + fh * 0.85),
            CGPoint(x: cx + fw * 0.3, y: oy + fh * 0.85),
            CGPoint(x: cx - fw * 0.25, y: oy + fh * 0.72),
            CGPoint(x: cx, y: oy + fh * 0.72),
            CGPoint(x: cx + fw * 0.25, y: oy + fh * 0.72),
            CGPoint(x: cx - fw * 0.2, y: oy + fh * 0.62),
            CGPoint(x: cx + fw * 0.2, y: oy + fh * 0.62),
            CGPoint(x: cx, y: oy + fh * 0.58)
        ]

        for (i, pos) in homeBasePositions.enumerated() {
            let p = makePlayerNode(color: resolvedHomeColor, isGoalkeeper: i == 0)
            p.position = pos
            addChild(p)
            homePlayers.append(p)
        }

        for (i, pos) in awayBasePositions.enumerated() {
            let p = makePlayerNode(color: resolvedAwayColor, isGoalkeeper: i == 0)
            p.position = pos
            addChild(p)
            awayPlayers.append(p)
        }
    }

    private func makePlayerNode(color: SKColor, isGoalkeeper: Bool) -> SKShapeNode {
        let node = SKShapeNode(circleOfRadius: playerRadius)
        if isGoalkeeper {
            node.fillColor = SKColor.yellow
            node.strokeColor = SKColor.black
        } else {
            node.fillColor = color
            node.strokeColor = SKColor(white: 1, alpha: 0.9)
        }
        node.lineWidth = 2
        node.zPosition = 10
        return node
    }

    private func placeBall() {
        ball = SKShapeNode(circleOfRadius: ballRadius)
        ball.fillColor = .white
        ball.strokeColor = .darkGray
        ball.lineWidth = 1.5
        ball.zPosition = 20

        let startCarrier = homePlayers[10]
        ballCarrier = startCarrier
        isHomePossession = true
        ball.position = CGPoint(x: startCarrier.position.x + ballOffset, y: startCarrier.position.y)
        addChild(ball)
    }

    func startSimulation() {
        isSimulating = true
        currentMinute = 0

        simulationTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] timer in
            guard let self = self, self.isSimulating else {
                timer.invalidate()
                return
            }
            self.tick()
        }
    }

    private func tick() {
        currentMinute += 1
        movePlayers()
        passBall()
        attachBallToCarrier()
        matchDelegate?.matchScene(self, didUpdateMinute: currentMinute)
        if currentMinute >= 90 {
            stopSimulation()
        }
    }

    private func passBall() {
        let turnoverChance: Double = 0.25
        let passChance: Double = 0.6

        let roll = Double.random(in: 0...1)

        if roll < turnoverChance {
            isHomePossession.toggle()
            let opponents = isHomePossession ? homePlayers : awayPlayers
            let fieldPlayers = Array(opponents[1...])
            if let nearest = fieldPlayers.min(by: { distSq($0.position, ball.position) < distSq($1.position, ball.position) }) {
                ballCarrier = nearest
            }
        } else if roll < turnoverChance + passChance {
            let teammates = isHomePossession ? homePlayers : awayPlayers
            let fieldPlayers = Array(teammates[1...])
            let candidates = fieldPlayers.filter { $0 !== ballCarrier }
            if let target = candidates.randomElement() {
                ballCarrier = target
            }
        }
    }

    private func attachBallToCarrier() {
        guard let carrier = ballCarrier else { return }
        let targetPos = CGPoint(x: carrier.position.x + ballOffset, y: carrier.position.y)
        let move = SKAction.move(to: targetPos, duration: 0.3)
        move.timingMode = .easeOut
        ball.run(move)
    }

    private func distSq(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        return (a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y)
    }

    private func movePlayers() {
        let carrierPos = ballCarrier?.position ?? ball.position
        let wanderRange: CGFloat = 25
        let chaseFraction: CGFloat = 0.10
        let carrierPull: CGFloat = 0.25

        for (i, player) in homePlayers.enumerated() {
            let base = homeBasePositions[i]
            let dx = CGFloat.random(in: -wanderRange...wanderRange)
            let dy = CGFloat.random(in: -wanderRange...wanderRange)

            let pull = (player === ballCarrier) ? 0.0 : (isHomePossession ? chaseFraction : carrierPull)
            var targetX = base.x + dx + (carrierPos.x - base.x) * pull
            var targetY = base.y + dy + (carrierPos.y - base.y) * pull

            if player === ballCarrier && isHomePossession {
                let attackDir: CGFloat = 1.0
                targetY = player.position.y + CGFloat.random(in: 5...30) * attackDir
                targetX = player.position.x + CGFloat.random(in: -20...20)
            }

            targetX = max(fieldRect.minX + playerRadius, min(fieldRect.maxX - playerRadius, targetX))
            targetY = max(fieldRect.minY + playerRadius, min(fieldRect.midY + fieldRect.height * 0.2, targetY))

            let move = SKAction.move(to: CGPoint(x: targetX, y: targetY), duration: 0.45)
            move.timingMode = .easeInEaseOut
            player.run(move)
        }

        for (i, player) in awayPlayers.enumerated() {
            let base = awayBasePositions[i]
            let dx = CGFloat.random(in: -wanderRange...wanderRange)
            let dy = CGFloat.random(in: -wanderRange...wanderRange)

            let pull = (player === ballCarrier) ? 0.0 : (!isHomePossession ? chaseFraction : carrierPull)
            var targetX = base.x + dx + (carrierPos.x - base.x) * pull
            var targetY = base.y + dy + (carrierPos.y - base.y) * pull

            if player === ballCarrier && !isHomePossession {
                let attackDir: CGFloat = -1.0
                targetY = player.position.y + CGFloat.random(in: 5...30) * attackDir
                targetX = player.position.x + CGFloat.random(in: -20...20)
            }

            targetX = max(fieldRect.minX + playerRadius, min(fieldRect.maxX - playerRadius, targetX))
            targetY = max(fieldRect.midY - fieldRect.height * 0.2, min(fieldRect.maxY - playerRadius, targetY))

            let move = SKAction.move(to: CGPoint(x: targetX, y: targetY), duration: 0.45)
            move.timingMode = .easeInEaseOut
            player.run(move)
        }
    }

    private var didFinish = false

    func pauseSimulation() {
        isSimulating = false
        simulationTimer?.invalidate()
        simulationTimer = nil
    }

    func resumeSimulation() {
        guard currentMinute < 90, !didFinish else { return }
        isSimulating = true
        simulationTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] timer in
            guard let self = self, self.isSimulating else {
                timer.invalidate()
                return
            }
            self.tick()
        }
    }

    func stopSimulation() {
        isSimulating = false
        simulationTimer?.invalidate()
        simulationTimer = nil
        guard !didFinish else { return }
        didFinish = true
        matchDelegate?.matchSceneDidFinish(self)
    }

    func forceStop() {
        isSimulating = false
        simulationTimer?.invalidate()
        simulationTimer = nil
    }

    override func willMove(from view: SKView) {
        forceStop()
    }
}

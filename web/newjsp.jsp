<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>World Cup Kickoff Countdown</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@700;800;900&family=Oswald:wght@500;700&display=swap');
    
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    
    :root {
      --primary: #00b2ff;
      --secondary: #0aff85;
      --accent: #ff0062;
      --dark: #001034;
      --light: #f0f9ff;
    }
    
    body {
      font-family: 'Montserrat', sans-serif;
      background: linear-gradient(135deg, var(--dark), #000814);
      color: var(--light);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      overflow: hidden;
      user-select: none;
    }
    
    .container {
      width: 650px;
      max-width: 90%;
      height: 650px;
      max-height: 90vh;
      position: relative;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
    }
    
    .stadium-bg {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-image: radial-gradient(circle at center, rgba(0,30,90,0.15) 0%, rgba(0,0,20,0.7) 70%);
      z-index: -1;
      overflow: hidden;
    }
    
    .crowd-wave {
      position: absolute;
      bottom: 0;
      left: 0;
      width: 100%;
      height: 25%;
      background: linear-gradient(0deg, rgba(0,40,100,0.3) 0%, transparent 100%);
      transform-origin: bottom center;
      animation: wave 8s ease-in-out infinite;
    }
    
    .event-details {
      margin-bottom: 2rem;
      text-align: center;
      transform: translateY(-30px);
    }
    
    .tournament {
      font-family: 'Oswald', sans-serif;
      font-size: 1.4rem;
      letter-spacing: 1px;
      background: linear-gradient(90deg, var(--primary), var(--secondary));
      -webkit-background-clip: text;
      background-clip: text;
      color: transparent;
      text-transform: uppercase;
      margin-bottom: 0.5rem;
    }
    
    .match {
      font-size: 2.5rem;
      font-weight: 900;
      margin-bottom: 0.5rem;
      text-shadow: 0 0 20px rgba(0, 178, 255, 0.5);
      line-height: 1.1;
    }
    
    .venue {
      font-size: 1rem;
      opacity: 0.8;
      margin-top: 0.5rem;
    }
    
    .countdown-wrapper {
      position: relative;
      width: 100%;
      padding: 1rem;
    }
    
    .pulse-ring {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      width: 400px;
      height: 400px;
      border-radius: 50%;
      border: 2px solid rgba(0, 178, 255, 0.3);
      animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
    }
    
    .pulse-ring:nth-child(2) {
      animation-delay: 0.5s;
    }
    
    .pulse-ring:nth-child(3) {
      animation-delay: 1s;
    }
    
    .countdown-container {
      display: flex;
      justify-content: center;
      perspective: 1000px;
      margin-top: 1rem;
    }
    
    .countdown-segment {
      display: flex;
      flex-direction: column;
      align-items: center;
      margin: 0 1rem;
      position: relative;
    }
    
    .segment-value {
      font-size: 5rem;
      font-weight: 800;
      line-height: 1;
      background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
      -webkit-background-clip: text;
      background-clip: text;
      color: transparent;
      position: relative;
      margin-bottom: 0.5rem;
      text-shadow: 0 5px 15px rgba(10, 255, 133, 0.3);
      transform-style: preserve-3d;
    }
    
    .segment-value::after {
      content: '';
      position: absolute;
      bottom: -5px;
      left: 50%;
      transform: translateX(-50%);
      width: 30px;
      height: 4px;
      background: linear-gradient(90deg, var(--primary), var(--secondary));
      border-radius: 2px;
    }
    
    .segment-label {
      font-size: 0.9rem;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 1px;
      color: rgba(240, 249, 255, 0.7);
    }
    
    .ticker {
      position: absolute;
      bottom: 2rem;
      left: 0;
      right: 0;
      background: rgba(0, 16, 52, 0.7);
      padding: 1rem;
      overflow: hidden;
      border-top: 1px solid rgba(0, 178, 255, 0.3);
      border-bottom: 1px solid rgba(0, 178, 255, 0.3);
    }
    
    .ticker-content {
      display: flex;
      animation: ticker 20s linear infinite;
      white-space: nowrap;
    }
    
    .ticker-item {
      margin-right: 50px;
      font-weight: 700;
      color: var(--light);
    }
    
    .ticker-highlight {
      color: var(--secondary);
    }
    
    .beat-animation {
      animation: beat 0.5s ease-out;
    }
    
    .cta-button {
      position: relative;
      margin-top: 2rem;
      padding: 0.8rem 2rem;
      font-family: 'Montserrat', sans-serif;
      font-weight: 700;
      font-size: 1rem;
      text-transform: uppercase;
      letter-spacing: 1px;
      background: linear-gradient(90deg, var(--primary), var(--secondary));
      border: none;
      border-radius: 30px;
      color: var(--dark);
      cursor: pointer;
      overflow: hidden;
      transition: all 0.3s ease;
      box-shadow: 0 5px 15px rgba(10, 255, 133, 0.3);
    }
    
    .cta-button:hover {
      transform: translateY(-3px);
      box-shadow: 0 8px 25px rgba(10, 255, 133, 0.5);
    }
    
    .cta-button::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
      transform: translateX(-100%);
    }
    
    .cta-button:hover::before {
      animation: shimmer 1.5s infinite;
    }
    
    /* Responsiveness */
    @media (max-width: 600px) {
      .tournament {
        font-size: 1rem;
      }
      
      .match {
        font-size: 1.8rem;
      }
      
      .segment-value {
        font-size: 3.5rem;
      }
      
      .countdown-segment {
        margin: 0 0.7rem;
      }
      
      .segment-label {
        font-size: 0.7rem;
      }
      
      .pulse-ring {
        width: 300px;
        height: 300px;
      }
    }
    
    /* Animations */
    @keyframes pulse {
      0% {
        transform: translate(-50%, -50%) scale(0.8);
        opacity: 0.8;
      }
      70% {
        opacity: 0.2;
      }
      100% {
        transform: translate(-50%, -50%) scale(1.2);
        opacity: 0;
      }
    }
    
    @keyframes wave {
      0%, 100% {
        transform: scaleY(1);
      }
      50% {
        transform: scaleY(1.1);
      }
    }
    
    @keyframes beat {
      0% {
        transform: scale(1);
      }
      50% {
        transform: scale(1.1);
      }
      100% {
        transform: scale(1);
      }
    }
    
    @keyframes ticker {
      0% {
        transform: translateX(0);
      }
      100% {
        transform: translateX(-100%);
      }
    }
    
    @keyframes shimmer {
      0% {
        transform: translateX(-100%);
      }
      100% {
        transform: translateX(100%);
      }
    }
    
    .flare {
      position: absolute;
      width: 5px;
      height: 5px;
      background-color: white;
      border-radius: 50%;
      box-shadow: 0 0 10px 2px rgba(0, 178, 255, 0.7);
      animation: flare-animation 4s infinite;
      opacity: 0;
    }
    
    @keyframes flare-animation {
      0% {
        opacity: 0;
        transform: scale(0);
      }
      20% {
        opacity: 1;
        transform: scale(1);
      }
      80% {
        opacity: 1;
      }
      100% {
        opacity: 0;
        transform: scale(0);
      }
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="stadium-bg">
      <div class="crowd-wave"></div>
    </div>
    
    <div class="pulse-ring"></div>
    <div class="pulse-ring"></div>
    <div class="pulse-ring"></div>
    
    
    
    <div class="countdown-wrapper">
      <div class="countdown-container" id="countdown">
        <div class="countdown-segment">
          <div class="segment-value" id="days">00</div>
          <div class="segment-label">Days</div>
        </div>
        <div class="countdown-segment">
          <div class="segment-value" id="hours">00</div>
          <div class="segment-label">Hours</div>
        </div>
        <div class="countdown-segment">
          <div class="segment-value" id="minutes">00</div>
          <div class="segment-label">Minutes</div>
        </div>
        <div class="countdown-segment">
          <div class="segment-value" id="seconds">00</div>
          <div class="segment-label">Seconds</div>
        </div>
      </div>
    </div>
    
    <button class="cta-button" id="reminder-btn">Set a Reminder</button>
    
    
  </div>

  <script>
    // Set the event date - July 15, 2026 at 20:00 UTC
    const eventDate = new Date('July 15, 2026 20:00:00 UTC').getTime();
    
    // Elements
    const daysEl = document.getElementById('days');
    const hoursEl = document.getElementById('hours');
    const minutesEl = document.getElementById('minutes');
    const secondsEl = document.getElementById('seconds');
    const countdownContainer = document.getElementById('countdown');
    const reminderBtn = document.getElementById('reminder-btn');
    
    // Random flare animation
    function createFlares() {
      const container = document.querySelector('.container');
      const flareCount = 10;
      
      for (let i = 0; i < flareCount; i++) {
        const flare = document.createElement('div');
        flare.className = 'flare';
        
        // Random position
        const posX = Math.random() * 100;
        const posY = Math.random() * 100;
        
        flare.style.left = `${posX}%`;
        flare.style.top = `${posY}%`;
        
        // Random delay
        flare.style.animationDelay = `${Math.random() * 5}s`;
        
        container.appendChild(flare);
      }
    }
    
    // Create flares
    createFlares();
    
    // Update countdown function
    function updateCountdown() {
      const now = new Date().getTime();
      const distance = eventDate - now;
      
      // Time calculations
      const days = Math.floor(distance / (1000 * 60 * 60 * 24));
      const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
      const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
      const seconds = Math.floor((distance % (1000 * 60)) / 1000);
      
      // Add leading zeros
      const formatNumber = num => num < 10 ? `0${num}` : num;
      
      // Update DOM
      daysEl.textContent = formatNumber(days);
      hoursEl.textContent = formatNumber(hours);
      minutesEl.textContent = formatNumber(minutes);
      secondsEl.textContent = formatNumber(seconds);
      
      // Beat animation on seconds change
      secondsEl.classList.add('beat-animation');
      setTimeout(() => {
        secondsEl.classList.remove('beat-animation');
      }, 500);
      
      // When countdown is over
      if (distance < 0) {
        clearInterval(countdown);
        daysEl.textContent = "00";
        hoursEl.textContent = "00";
        minutesEl.textContent = "00";
        secondsEl.textContent = "00";
        
        // Add "LIVE NOW" message
        const eventDetails = document.querySelector('.event-details');
        const liveNow = document.createElement('div');
        liveNow.textContent = "LIVE NOW";
        liveNow.style.color = "var(--accent)";
        liveNow.style.fontSize = "2rem";
        liveNow.style.fontWeight = "900";
        liveNow.style.marginTop = "1rem";
        liveNow.style.animation = "beat 1s infinite";
        eventDetails.appendChild(liveNow);
      }
    }
    
    // Initial call
    updateCountdown();
    
    // Update every second
    const countdown = setInterval(updateCountdown, 1000);
    
    // Reminder button functionality
    reminderBtn.addEventListener('click', function() {
      this.textContent = "Reminder Set!";
      this.style.background = "linear-gradient(90deg, #0aff85, #00b2ff)";
      setTimeout(() => {
        this.textContent = "Set a Reminder";
        this.style.background = "linear-gradient(90deg, var(--primary), var(--secondary))";
      }, 3000);
      
      // Trigger more pulse rings on click
      const container = document.querySelector('.container');
      for (let i = 0; i < 3; i++) {
        const extraPulse = document.createElement('div');
        extraPulse.className = 'pulse-ring';
        extraPulse.style.animationDelay = `${i * 0.2}s`;
        extraPulse.style.animationDuration = '1s';
        container.appendChild(extraPulse);
        
        // Remove the extra pulse after animation
        setTimeout(() => {
          extraPulse.remove();
        }, 1000);
      }
    });
    
    // Make ticker content dynamic
    const tickerContent = document.querySelector('.ticker-content');
    const originalWidth = tickerContent.offsetWidth;
    tickerContent.style.animationDuration = `${originalWidth / 50}s`;
  </script>
</body>
</html>
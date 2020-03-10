;extensions [vid nw]

breed [tanks tank]
breed [infantries infantry]
breed [artilleries artillery]
breed [bunkers bunker]
breed [targets target]

turtles-own [
  side                   ; 0 for Germans 1 for Allies
  energy                 ; energy left
  hit                    ; probability to hit
  frange                 ; fire range
  infantry-damage        ; impact on enemy infantry
  tank-damage            ; impact on enemy tank
  artillery-damage       ; impact on enemy artillery
  bunker-damage          ; impact on enemy bunker
  self-target-id-first   ; target checkpoint (US troops)
  self-target-id-second  ; target checkpoint (US troops)
]

globals [
  game-over?

  turtlecount       ; indices of turtles
  target-id-first
  target-id-second
  Dog-G-inf         ;infantry in dog green
  Dog-W-inf
  Dog-R-inf
  Easy-inf
  Fox-inf

  ; Sizes
  warships-size
  bunkers-size
  infantry-size
  targets-size
  artillery-size
  tank-size

  ; US Infantries
  ;; Properties
  ; infantry-US-energy  ; slider
  ; infantry-US-hit     ; slider
  ; infantry-US-frange  ; slider
  ;; Damage table
  infantry-US-infantry-damage
  infantry-US-tank-damage
  infantry-US-artillery-damage
  infantry-US-bunker-damage

  ; US Artillery
  ;; Properties
  artillery-US-energy
  artillery-US-hit
  artillery-US-frange
  ;; Damage table
  artillery-US-infantry-damage
  artillery-US-tank-damage
  artillery-US-artillery-damage
  artillery-US-bunker-damage

  ; GE Bunkers
  ;; Properties
  bunker-GE-energy
  bunker-GE-hit
  bunker-GE-frange
  ;; Damage table
  bunker-GE-infantry-damage
  bunker-GE-tank-damage
  bunker-GE-artillery-damage

  ; GE Artilleries
  ;; Properties
  artillery-GE-energy
  artillery-GE-hit
  artillery-GE-frange
  ;; Damage table
  artillery-GE-infantry-damage
  artillery-GE-tank-damage
  artillery-GE-artillery-damage

  ; GE Tanks
  ;; Properties
  tank-GE-energy
  tank-GE-hit
  tank-GE-frange
  ;; Damage table
  tank-GE-infantry-damage
  tank-GE-tank-damage
  tank-GE-artillery-damage


  temp

]

to init-variables
  set game-over? false
  set turtlecount 0

  ; Sizes
  set warships-size 25
  set infantry-size 2
  set bunkers-size 10
  set targets-size 10
  set artillery-size 13
  set tank-size 20

  ; US Infantries
  ;; Properties
  ; infantry-US-energy
  ; infantry-US-hit
  ; infantry-US-frange
  ;; Damage table
  set infantry-US-infantry-damage 5
  set infantry-US-tank-damage 5
  set infantry-US-artillery-damage 20
  set infantry-US-bunker-damage 3

  ; US Artillery (warships)
  ;; Properties
  set artillery-US-energy infantry-US-energy * 10
  set artillery-US-hit infantry-US-hit
  set artillery-US-frange infantry-US-frange * 20
  ;; Damage table
  set artillery-US-infantry-damage 7
  set artillery-US-tank-damage 10
  set artillery-US-artillery-damage 1
  set artillery-US-bunker-damage 1

  ; GE Bunkers
  ;; Properties
  set bunker-GE-energy infantry-GE-energy * 50
  set bunker-GE-hit infantry-GE-hit * 1
  set bunker-GE-frange infantry-GE-frange * 2
  ;; Damage table
  set bunker-GE-infantry-damage 5
  set bunker-GE-tank-damage 1
  set bunker-GE-artillery-damage 1

  ; GE Artillery (canons)
  ;; Properties
  set artillery-GE-energy infantry-GE-energy * 5
  set artillery-GE-hit 1
  set artillery-GE-frange infantry-GE-frange * 7
  ;; Damage table
  set artillery-GE-infantry-damage 10
  set artillery-GE-tank-damage 0.5
  set artillery-GE-artillery-damage 0.5

  ; GE Tanks
  ;; Properties
  set tank-GE-energy infantry-GE-energy * 40
  set tank-GE-hit infantry-GE-hit * 5
  set tank-GE-frange infantry-GE-frange * 3
  ;; Damage table
  set tank-GE-infantry-damage 40
  set tank-GE-tank-damage 15
  set tank-GE-artillery-damage 10
end

to setup
  random-seed 1994
  clear-all
  reset-ticks
  import-pcolors "bg/realistic_clean.jpg"
  init-variables
  setup-turtles
end

to go
  clear-links
  if ticks >= 700 [ stop ]
  if ticks = Tank-Delay [ GE-setup-tank ]
  ask bunkers [	
    set label round energy	
  ]	
  ask tanks [	
    set label round energy	
  ]
  if ticks = 1 [
    set Dog-G-inf  24
    set Dog-W-inf 12
    set Dog-R-inf 12
    set Easy-inf 48
    set Fox-inf 48
    US-New-Infantries

  ]
  if ticks = 3 [
    set Dog-G-inf 38
    set Dog-W-inf 30
    set Dog-R-inf 30
    set Easy-inf 100
    set Fox-inf 20
    US-New-Infantries

  ]
  if ticks = 8 [
    set Dog-G-inf 0
    set Dog-W-inf 0
    set Dog-R-inf 0
    set Easy-inf 30 ;red
    set Fox-inf 10
    US-New-Infantries

  ]
  if ticks = 25 [
    set Dog-G-inf 0
    set Dog-W-inf 0
    set Dog-R-inf 0
    set Easy-inf 40  ; red
    set Fox-inf 20
    US-New-Infantries

  ]
  if ticks = 30 [
    set Dog-G-inf 34
    set Dog-W-inf 10
    set Dog-R-inf 16
    set Easy-inf 36   ;10 green+ 26 red
    set Fox-inf 38
    US-New-Infantries

  ]
  if ticks = 40 [
    set Dog-G-inf 38
    set Dog-W-inf 12
    set Dog-R-inf 18
    set Easy-inf 32 ;10G + 22R
    set Fox-inf 24
    US-New-Infantries

  ]
  if ticks = 50 [
    set Dog-G-inf 24
    set Dog-W-inf 12
    set Dog-R-inf 14
    set Easy-inf 40 ;14G + 26R
    set Fox-inf 16
    US-New-Infantries

  ]
  if ticks = 57 [
    set Dog-G-inf  8
    set Dog-W-inf 0
    set Dog-R-inf 18
    set Easy-inf 0
    set Fox-inf 0
    US-New-Infantries

  ]
  if ticks = 60 [
    set Dog-G-inf 20
    set Dog-W-inf 2
    set Dog-R-inf 2
    set Easy-inf 0
    set Fox-inf 0
    US-New-Infantries

  ]
  if ticks = 65 [
    set Dog-G-inf 28
    set Dog-W-inf 0
    set Dog-R-inf 0
    set Easy-inf 30  ;R
    set Fox-inf 26
    US-New-Infantries

  ]
  if ticks = 70 [
    set Dog-G-inf  42
    set Dog-W-inf 20
    set Dog-R-inf 20
    set Easy-inf 44  ;20G + 24R
    set Fox-inf 0
    US-New-Infantries

  ]
  if ticks = 80 [
    set Dog-G-inf  0
    set Dog-W-inf 0
    set Dog-R-inf 0
    set Easy-inf 24 ;R
    set Fox-inf 0
    US-New-Infantries

  ]
  if ticks = 90 [
    set Dog-G-inf  0
    set Dog-W-inf 0
    set Dog-R-inf 0
    set Easy-inf 18 ;R
    set Fox-inf 0
    US-New-Infantries

  ]
  if ticks = 95 [
    set Dog-G-inf 0
    set Dog-W-inf 0
    set Dog-R-inf 0
    set Easy-inf 12 ;R
    set Fox-inf 0
    US-New-Infantries

  ]
  if ticks = 100 [
    set Dog-G-inf 0
    set Dog-W-inf 20
    set Dog-R-inf 0
    set Easy-inf 0
    set Fox-inf 0
    US-New-Infantries

  ]
  if ticks = 105 [
    set Dog-G-inf 0
    set Dog-W-inf 0
    set Dog-R-inf 0
    set Easy-inf 20 ;R
    set Fox-inf 3
    US-New-Infantries

  ]
  if ticks = 110 [
    set Dog-G-inf 10
    set Dog-W-inf 0
    set Dog-R-inf 7
    set Easy-inf 43  ; 13G + 30R
    set Fox-inf 0
    US-New-Infantries

  ]
  if ticks = 120 [
    set Dog-G-inf 0
    set Dog-W-inf 0
    set Dog-R-inf 0
    set Easy-inf 44 ;R
    set Fox-inf 0
    US-New-Infantries

  ]
  if ticks = 130 [
    set Dog-G-inf 0
    set Dog-W-inf 0
    set Dog-R-inf 0
    set Easy-inf 0
    set Fox-inf 0
    US-New-Infantries

  ]
  if ticks = 135 [
    set Dog-G-inf 0
    set Dog-W-inf 0
    set Dog-R-inf 0
    set Easy-inf 0
    set Fox-inf 8
    US-New-Infantries

  ]
  if ticks = 150 [
    set Dog-G-inf 0
    set Dog-W-inf 20
    set Dog-R-inf 0
    set Easy-inf 0
    set Fox-inf 0
    US-New-Infantries

  ]
  if ticks = 180 [
    set Dog-G-inf 0
    set Dog-W-inf 30
    set Dog-R-inf 0
    set Easy-inf 32 ; 18R + 4R+ 1 Rhino???
    set Fox-inf 0  ;2 Rhino??
    US-New-Infantries

  ]
  if ticks = 185 [
    set Dog-G-inf 0
    set Dog-W-inf 0
    set Dog-R-inf 0
    set Easy-inf 20 ;R
    set Fox-inf 10
    US-New-Infantries

  ]
  if ticks = 195 [
    set Dog-G-inf 0
    set Dog-W-inf 0
    set Dog-R-inf 0
    set Easy-inf 76 ;R
    set Fox-inf 0
    US-New-Infantries

  ]
  if ticks = 210 [
    set Dog-G-inf 0
    set Dog-W-inf 0
    set Dog-R-inf 0
    set Easy-inf 180 ;R
    set Fox-inf 0
    US-New-Infantries

  ]
  if ticks = 220 [
    set Dog-G-inf 0
    set Dog-W-inf 0
    set Dog-R-inf 0
    set Easy-inf 0
    set Fox-inf 0
    US-New-Infantries
  ]
  if ticks = 225 [
    set Dog-G-inf 0
    set Dog-W-inf 0
    set Dog-R-inf 0
    set Easy-inf 0
    set Fox-inf 0
    US-New-Infantries
  ]


	US-move
  GE-move
  if ticks mod 2 = 0 [
    fight
  ]

  if ticks > 60 [
    win-or-lose
  ]
  if game-over? [ stop ]

  tick
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MOVES AND FIGHTS
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to US-move

  ; US infantry move
  ask infantries with [(side = 1)] [
    ; Don't move if can fire at enemy
    ; Check for enemies under fire range
    let can-fire 0

    ifelse ycor < -200 [
      ask turtles in-radius frange [
        if ([side] of self - [side] of myself = -1) [
          set can-fire 1
        ]
      ]
    ] [ ]

    ifelse can-fire = 0 [
      ; Don't fire and move to target checkpoint
      ifelse ycor > [ycor] of self-target-id-first [
        set heading towards self-target-id-first + random 50 * one-of [1 -1]
        forward 0.7
        if ycor > -200 [
          forward 2
        ]
      ][
        ask self-target-id-first [
          set color blue
        ]
        ifelse ycor > [ycor] of self-target-id-second [
          set heading towards self-target-id-second
          forward 1
        ][
          ask self-target-id-second [
            set color blue
          ]
        ]
      ]
    ][

      let bunkers-existing false
      ; Target bunkers
      ask bunkers [
        ifelse distance myself <= [frange] of myself [

          set bunkers-existing true
          if random-float 1 < 0.2 [
            create-link-to myself [set color sky]
            set energy energy - [bunker-damage] of myself ]
        ][






        ]
      ]

      if bunkers-existing = false [
        ; Target bunkers
        ask tanks [
          ifelse distance myself <= [frange] of myself [
            if random-float 1 < 0.2 [
              create-link-to myself [set color sky]
              set energy energy - [tank-damage] of myself ]
          ][ ]
        ]


      ]

    ]

  ]

end

to GE-move

  ; GE tanks move
  ask tanks with [(side = 0)] [

    ; Don't move if can fire at enemy
    ; Check for enemies under fire range
    let can-fire 0
    if ycor >= [ycor] of self-target-id-first [
        set can-fire 1
     ]
    ask turtles in-radius frange [
      if [side] of self - [side] of myself = -1 [
        set can-fire 1
        stop
      ]
    ]

    ifelse can-fire = 0 [
      ; Don't fire and move to target checkpoint
      ifelse ycor < [ycor] of self-target-id-second [
        set heading towards self-target-id-second + random 10 * one-of [1 -1]
        forward 1.5
      ][
        set heading towards self-target-id-first
        forward 1
      ]
    ][

      ; Tank
      ask tanks [
        ; Target infantry
        set temp one-of infantries in-radius frange
        ;show temp
        if temp != nobody [
          ask infantries [
            if [distance myself] of temp < 5 and [ycor] of temp < -190 [
              create-link-to myself [set color red]
              set energy energy - infantry-damage
            ]

          ]
        ]
      ]

    ]

  ]

end

to fight

  ; Bunker
  ask bunkers [
    ; Target infantry
    set temp one-of infantries in-radius frange
    if temp != nobody [
      ask infantries [
        if [distance myself] of temp < 4 and [ycor] of temp < -200 [
          create-link-to myself [set color gray]
          set energy energy - infantry-damage
        ]
        if [distance myself] of temp < 4 and [ycor] of temp > -200 and random-float 1 < 0.2 [
          create-link-to myself [set color gray]
          set energy energy - (infantry-damage)
        ]

      ]
    ]
  ]

  ; Artillery
  ask artilleries [
    ; Target infantry
    set temp one-of infantries in-radius frange with [(side = 1 - [side] of myself)]
    if temp != nobody [
      ask infantries [
        if [distance myself] of temp < 4 and [ycor] of temp < -200 [
          create-link-to myself [set color orange]
          set energy energy - infantry-damage
        ]
        if [distance myself] of temp < 4 and [ycor] of temp > -200 and random-float 1 < 0.2 [
          create-link-to myself [set color orange]
          set energy energy - (infantry-damage)
        ]

      ]
    ]
  ]


  ; Every agent with zero or negative energy dies
  ask turtles [ if energy < 1 [
    ;show who
    die
  ]]
end


to win-or-lose
  if count infantries > 600 and (count targets with [color = blue]) >= 6 [
    user-message "US WIN"
    set game-over? true ]

  if count infantries  < 200 [
    user-message "GE WIN"
    set game-over? true ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; AGENTS AND THEIR INITIAL POSITIONS, PROPERTIES
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to setup-turtles
  US-setup
  GE-setup
end

;;;;;;;;;;;;;;;;;;
;; US TROOPS
;;;;;;;;;;;;;;;;;;

to US-setup
  set-default-shape artilleries "boat top"
  set-default-shape targets "x"
  set-default-shape infantries "person soldier"
  US-setup-DOG    ; left most US warships
  US-setup-EASY
  US-setup-FOX    ; right most US warship
end

to US-setup-DOG
  let number 0

  ; Warship 1
  create-artilleries 1
  ask artillery turtlecount [
    set color blue
    setxy 110 -20
    set heading 90
    set size warships-size
    set side 1
    ; Properties
    set energy artillery-US-energy
    set hit artillery-US-hit
    set frange artillery-US-frange
    ; Damage table
    set infantry-damage artillery-US-infantry-damage
    set tank-damage artillery-US-tank-damage
    set artillery-damage artillery-US-artillery-damage
    set bunker-damage artillery-US-bunker-damage
  ]
  set turtlecount turtlecount + 1

  ; DOG land target 1
  ; For units from Warship 1
  create-targets 1
  ask target turtlecount [
    set color brown
    setxy 93 -233
    set heading 90
    set size targets-size
    set side 1
    set energy 1
  ]
  set target-id-first turtlecount
  set turtlecount turtlecount + 1

  ; DOG land target 2
  ; For units from Warship 1
  create-targets 1
  ask target turtlecount [
    set color brown
    setxy 103 -270
    set heading 90
    set size targets-size
    set side 1
    set energy 1
  ]
  set target-id-second turtlecount
  set turtlecount turtlecount + 1

  ; US Infantry from DOG
  ; Leave from Warship 1
;  set number 30
;  create-infantries number
;	ask infantries with [energy = 0] [
;    set color blue
;    setxy 110 -30 + random 10
;    set heading 180
;    set size infantry-size
;    set side 1
;    ; Properties
;    set energy infantry-US-energy
;    set frange infantry-US-frange
;    set hit infantry-US-hit
;    set frange infantry-US-frange
;    ; Damage table
;    set infantry-damage infantry-US-infantry-damage
;    set tank-damage infantry-US-tank-damage
;    set artillery-damage infantry-US-artillery-damage
;    set bunker-damage infantry-US-bunker-damage
;    ; Targets
;    set self-target-id-first target-id-first
;    set self-target-id-second target-id-second
;	]
;  set turtlecount turtlecount + number

  ; Warship 2
  create-artilleries 1
  ask artillery turtlecount [
    set color blue
    setxy 180 -20
    set heading 90
    set size warships-size
    set side 1
    ; Properties
    set energy artillery-US-energy
    set hit artillery-US-hit
    set frange artillery-US-frange
    ; Damage table
    set infantry-damage artillery-US-infantry-damage
    set tank-damage artillery-US-tank-damage
    set artillery-damage artillery-US-artillery-damage
    set bunker-damage artillery-US-bunker-damage
  ]
  set turtlecount turtlecount + 1

  ; DOG land target 1
  ; For units from Warship 2
  create-targets 1
  ask target turtlecount [
    set color brown
    setxy 240 -250
    set heading 90
    set size targets-size
    set side 1
    set energy 1
  ]
  set target-id-first turtlecount
  set turtlecount turtlecount + 1

  ; DOG land target 2
  ; For units from Warship 2
  create-targets 1
  ask target turtlecount [
    set color brown
    setxy 246 -285
    set heading 90
    set size targets-size
    set side 1
    set energy 1
  ]
  set target-id-second turtlecount
  set turtlecount turtlecount + 1

  ; US Infantry from DOG
  ; Leave from Warship 2
;  set number 30
;  create-infantries number
;  ask infantries with [energy = 0] [
;    set color blue
;    setxy 180 -30 + random 10
;    set heading 180
;    set size infantry-size
;    set side 1
;    ; Properties
;    set energy infantry-US-energy
;    set frange infantry-US-frange
;    set hit infantry-US-hit
;    set frange infantry-US-frange
;    ; Damage table
;    set infantry-damage infantry-US-infantry-damage
;    set tank-damage infantry-US-tank-damage
;    set artillery-damage infantry-US-artillery-damage
;    set bunker-damage infantry-US-bunker-damage
;    ; Targets
;    set self-target-id-first target-id-first
;    set self-target-id-second target-id-second
;	]
;  set turtlecount turtlecount + number

  ; Warship 3
  create-artilleries 1
  ask artillery turtlecount [
    set color blue
    setxy 250 -20
    set heading 90
    set size warships-size
    set side 1
    ; Properties
    set energy artillery-US-energy
    set hit artillery-US-hit
    set frange artillery-US-frange
    ; Damage table
    set infantry-damage artillery-US-infantry-damage
    set tank-damage artillery-US-tank-damage
    set artillery-damage artillery-US-artillery-damage
    set bunker-damage artillery-US-bunker-damage
  ]
  set turtlecount turtlecount + 1

  ; US Infantry from DOG
  ; Leave from Warship 3
;  set number 30
;  create-infantries number
;  ask infantries with [energy = 0] [
;    set color blue
;    setxy 250 -30 + random 10
;    set heading 180
;    set size infantry-size
;    set side 1
;    ; Properties
;    set energy infantry-US-energy
;    set frange infantry-US-frange
;    set hit infantry-US-hit
;    set frange infantry-US-frange
;    ; Damage table
;    set infantry-damage infantry-US-infantry-damage
;    set tank-damage infantry-US-tank-damage
;    set artillery-damage infantry-US-artillery-damage
;    set bunker-damage infantry-US-bunker-damage
;    ; Targets
;    set self-target-id-first target-id-first
;    set self-target-id-second target-id-second
;	]
;  set turtlecount turtlecount + number

end

to US-setup-EASY
  let number 0

  ; Warhsip 1
  create-artilleries 1
  ask artillery turtlecount [
    set color blue
    setxy 370 -20
    set heading 90
    set size warships-size
    set side 1
    ; Properties
    set energy artillery-US-energy
    set hit artillery-US-hit
    set frange artillery-US-frange
    ; Damage table
    set infantry-damage artillery-US-infantry-damage
    set tank-damage artillery-US-tank-damage
    set artillery-damage artillery-US-artillery-damage
    set bunker-damage artillery-US-bunker-damage
  ]
  set turtlecount turtlecount + 1

  ; EASY land target 1
  ; For units from Warship 1
  create-targets 1
  ask target turtlecount [
    set color brown
    setxy 338 -250
    set heading 90
    set size targets-size
    set side 1
    set energy 1
  ]
  set target-id-first turtlecount
  set turtlecount turtlecount + 1

  ; EASY land target 2
  ; For units from Warship 1
  create-targets 1
  ask target turtlecount [
    set color brown
    setxy 340 -273
    set heading 90
    set size targets-size
    set side 1
    set energy 1
  ]
  set target-id-second turtlecount
  set turtlecount turtlecount + 1

  ; US Infantry from EASY
  ; Leave from Warship 1
;  set number 30
;  create-infantries number
;  ask infantries with [energy = 0] [
;    set color blue
;    setxy 370 -30 + random 10
;    set heading 180
;    set size infantry-size
;    set side 1
;    ; Properties
;    set energy infantry-US-energy
;    set frange infantry-US-frange
;    set hit infantry-US-hit
;    set frange infantry-US-frange
;    ; Damage table
;    set infantry-damage infantry-US-infantry-damage
;    set tank-damage infantry-US-tank-damage
;    set artillery-damage infantry-US-artillery-damage
;    set bunker-damage infantry-US-bunker-damage
;    ; Targets
;    set self-target-id-first target-id-first
;    set self-target-id-second target-id-second
;	]
;  set turtlecount turtlecount + number

end

to US-setup-FOX
  let number 0

  ; Warhsip 1
  create-artilleries 1
  ask artillery turtlecount [
    set color blue
    setxy 480 -20
    set heading 90
    set size warships-size
    set side 1
    ; Properties
    set energy artillery-US-energy
    set hit artillery-US-hit
    set frange artillery-US-frange
    ; Damage table
    set infantry-damage artillery-US-infantry-damage
    set tank-damage artillery-US-tank-damage
    set artillery-damage artillery-US-artillery-damage
    set bunker-damage artillery-US-bunker-damage
  ]
  set turtlecount turtlecount + 1

  ; FOX land target 1
  ; For units from Warship 1
  create-targets 1
  ask target turtlecount [
    set color brown
    setxy 450 -250
    set heading 90
    set size targets-size
    set side 1
    set energy 1
  ]
  set target-id-first turtlecount
  set turtlecount turtlecount + 1

  ; FOX land target 2
  ; For units from Warship 1
  create-targets 1
  ask target turtlecount [
    set color brown
    setxy 453 -290
    set heading 90
    set size targets-size
    set side 1
    set energy 1
  ]
  set target-id-second turtlecount
  set turtlecount turtlecount + 1

  ; US Infantry from FOX
  ; Leave from Warship 1
;  set number 30
;  create-infantries number
;  ask infantries with [energy = 0] [
;    set color blue
;    setxy 480 -30 + random 10
;    set heading 180
;    set size infantry-size
;    set side 1
;    ; Properties
;    set energy infantry-US-energy
;    set frange infantry-US-frange
;    set hit infantry-US-hit
;    set frange infantry-US-frange
;    ; Damage table
;    set infantry-damage infantry-US-infantry-damage
;    set tank-damage infantry-US-tank-damage
;    set artillery-damage infantry-US-artillery-damage
;    set bunker-damage infantry-US-bunker-damage
;    ; Targets
;    set self-target-id-first target-id-first
;    set self-target-id-second target-id-second
;	]
;  set turtlecount turtlecount + number
end

;;;;;;;;;;;;;;;;;;
;; GE TROOPS
;;;;;;;;;;;;;;;;;;

to GE-setup
  GE-setup-bunkers
  GE-setup-artillery
end

to GE-setup-bunkers
  ; Bunkers
  set-default-shape bunkers "square"
  set-default-shape tanks "tank"

  ; Vierville
  create-bunkers 1
  ask bunker turtlecount [
    set color red
    setxy 80 -229
    set heading 90
    set size bunkers-size
    set side 0
    ; Properties
    set energy bunker-GE-energy
    set hit bunker-GE-hit
    set frange bunker-GE-frange
    ; Damage table
    set infantry-damage bunker-GE-infantry-damage
    set tank-damage bunker-GE-tank-damage
    set artillery-damage bunker-GE-artillery-damage
  ]
  set turtlecount turtlecount + 1

  create-bunkers 1
  ask bunker turtlecount [
    set color red
    setxy 105 -235
    set heading 90
    set size bunkers-size
    set side 0
    ; Properties
    set energy bunker-GE-energy
    set hit bunker-GE-hit
    set frange bunker-GE-frange
    ; Damage table
    set infantry-damage bunker-GE-infantry-damage
    set tank-damage bunker-GE-tank-damage
    set artillery-damage bunker-GE-artillery-damage
  ]
  set turtlecount turtlecount + 1

  ; Les moulins
  create-bunkers 1
  ask bunker turtlecount [
    set color red
    setxy 229 -250
    set heading 90
    set size bunkers-size
    set side 0
    ; Properties
    set energy bunker-GE-energy
    set hit bunker-GE-hit
    set frange bunker-GE-frange
    ; Damage table
    set infantry-damage bunker-GE-infantry-damage
    set tank-damage bunker-GE-tank-damage
    set artillery-damage bunker-GE-artillery-damage
  ]
  set turtlecount turtlecount + 1

  create-bunkers 1
  ask bunker turtlecount [
    set color red
    setxy 250 -250
    set heading 90
    set size bunkers-size
    set side 0
    ; Properties
    set energy bunker-GE-energy
    set hit bunker-GE-hit
    set frange bunker-GE-frange
    ; Damage table
    set infantry-damage bunker-GE-infantry-damage
    set tank-damage bunker-GE-tank-damage
    set artillery-damage bunker-GE-artillery-damage
  ]
  set turtlecount turtlecount + 1

  ; Saint Laurent
  create-bunkers 1
  ask bunker turtlecount [
    set color red
    setxy 328 -250
    set heading 90
    set size bunkers-size
    set side 0
    ; Properties
    set energy bunker-GE-energy
    set hit bunker-GE-hit
    set frange bunker-GE-frange
    ; Damage table
    set infantry-damage bunker-GE-infantry-damage
    set tank-damage bunker-GE-tank-damage
    set artillery-damage bunker-GE-artillery-damage
  ]
  set turtlecount turtlecount + 1

  create-bunkers 1
  ask bunker turtlecount [
    set color red
    setxy 348 -250
    set heading 90
    set size bunkers-size
    set side 0
    ; Properties
    set energy bunker-GE-energy
    set hit bunker-GE-hit
    set frange bunker-GE-frange
    ; Damage table
    set infantry-damage bunker-GE-infantry-damage
    set tank-damage bunker-GE-tank-damage
    set artillery-damage bunker-GE-artillery-damage
  ]
  set turtlecount turtlecount + 1

  ; Colleville
  create-bunkers 1
  ask bunker turtlecount [
    set color red
    setxy 430 -248
    set heading 90
    set size bunkers-size
    set side 0
    ; Properties
    set energy bunker-GE-energy
    set hit bunker-GE-hit
    set frange bunker-GE-frange
    ; Damage table
    set infantry-damage bunker-GE-infantry-damage
    set tank-damage bunker-GE-tank-damage
    set artillery-damage bunker-GE-artillery-damage
  ]
  set turtlecount turtlecount + 1

  create-bunkers 1
  ask bunker turtlecount [
    set color red
    setxy 483 -240
    set heading 90
    set size bunkers-size
    set side 0
    ; Properties
    set energy bunker-GE-energy
    set hit bunker-GE-hit
    set frange bunker-GE-frange
    ; Damage table
    set infantry-damage bunker-GE-infantry-damage
    set tank-damage bunker-GE-tank-damage
    set artillery-damage bunker-GE-artillery-damage
  ]
  set turtlecount turtlecount + 1

end

to GE-setup-artillery
  ; GE artillery was located at Longues-sur-Mer
  ; east from Omaha Beach (https://en.wikipedia.org/wiki/Longues-sur-Mer_battery)
  ; in french "sur-Mer" means literally "on-sea", and is used in cities' name which are settled close to the shore
  set-default-shape artilleries "canon"

  create-artilleries 1
  ask artilleries with [(side = 0) and (energy = 0)] [
    set color red
    setxy 60 -340
    set heading 0
    set size artillery-size
    set side 0
    ; Properties
    set energy artillery-GE-energy
    set hit artillery-GE-hit
    set frange artillery-GE-frange
    ; Damage table
    set infantry-damage artillery-GE-infantry-damage
    set tank-damage artillery-GE-tank-damage
    set artillery-damage artillery-GE-artillery-damage
  ]
  create-artilleries 1
  ask artilleries with [(side = 0) and (energy = 0)] [
    set color red
    setxy 200 -340
    set heading 0
    set size artillery-size
    set side 0
    ; Properties
    set energy artillery-GE-energy
    set hit artillery-GE-hit
    set frange artillery-GE-frange
    ; Damage table
    set infantry-damage artillery-GE-infantry-damage
    set tank-damage artillery-GE-tank-damage
    set artillery-damage artillery-GE-artillery-damage
  ]

  create-artilleries 1
  ask artilleries with [(side = 0) and (energy = 0)] [
    set color red
    setxy 390 -340
    set heading 0
    set size artillery-size
    set side 0
    ; Properties
    set energy artillery-GE-energy
    set hit artillery-GE-hit
    set frange artillery-GE-frange
    ; Damage table
    set infantry-damage artillery-GE-infantry-damage
    set tank-damage artillery-GE-tank-damage
    set artillery-damage artillery-GE-artillery-damage
  ]

  create-artilleries 1
  ask artilleries with [(side = 0) and (energy = 0)] [
    set color red
    setxy 550 -340
    set heading 0
    set size artillery-size
    set side 0
    ; Properties
    set energy artillery-GE-energy
    set hit artillery-GE-hit
    set frange artillery-GE-frange
    ; Damage table
    set infantry-damage artillery-GE-infantry-damage
    set tank-damage artillery-GE-tank-damage
    set artillery-damage artillery-GE-artillery-damage
  ]
end

to GE-setup-tank
  ; GE artillery was located at XXX
  set-default-shape tanks "tank"

  create-tanks 1
  ask tanks with [(side = 0) and (energy = 0)] [
    set color red
    setxy 70 -370
    set heading 0
    set size tank-size
    set side 0
    ; Properties
    set energy tank-GE-energy
    set hit tank-GE-hit
    set frange tank-GE-frange
    ; Damage table
    set tank-damage tank-GE-infantry-damage
    set tank-damage tank-GE-tank-damage
    set tank-damage tank-GE-artillery-damage
    ; Target
    set self-target-id-second min-one-of targets [distance myself]
    ;show [who] of self-target-id-second
    set self-target-id-first target ([who] of self-target-id-second - 1)
    ;show [who] of self-target-id-first
  ]

  create-tanks 1
  ask tanks with [(side = 0) and (energy = 0)] [
    set color red
    setxy 220 -370
    set heading 0
    set size tank-size
    set side 0
    ; Properties
    set energy tank-GE-energy
    set hit tank-GE-hit
    set frange tank-GE-frange
    ; Damage table
    set tank-damage tank-GE-infantry-damage
    set tank-damage tank-GE-tank-damage
    set tank-damage tank-GE-artillery-damage
    ; Target
    set self-target-id-second min-one-of targets [distance myself]
    ;show [who] of self-target-id-second
    set self-target-id-first target ([who] of self-target-id-second - 1)
    ;show [who] of self-target-id-first
  ]

  create-tanks 1
  ask tanks with [(side = 0) and (energy = 0)] [
    set color red
    setxy 350 -370
    set heading 0
    set size tank-size
    set side 0
    ; Properties
    set energy tank-GE-energy
    set hit tank-GE-hit
    set frange tank-GE-frange
    ; Damage table
    set tank-damage tank-GE-infantry-damage
    set tank-damage tank-GE-tank-damage
    set tank-damage tank-GE-artillery-damage
    ; Target
    set self-target-id-second min-one-of targets [distance myself]
    ;show [who] of self-target-id-second
    set self-target-id-first target ([who] of self-target-id-second - 1)
    ;show [who] of self-target-id-first
  ]

  create-tanks 1
  ask tanks with [(side = 0) and (energy = 0)] [
    set color red
    setxy 500 -370
    set heading 0
    set size tank-size
    set side 0
    ; Properties
    set energy tank-GE-energy
    set hit tank-GE-hit
    set frange tank-GE-frange
    ; Damage table
    set tank-damage tank-GE-infantry-damage
    set tank-damage tank-GE-tank-damage
    set tank-damage tank-GE-artillery-damage
    ; Target
    set self-target-id-second min-one-of targets [distance myself]
    ;show [who] of self-target-id-second
    set self-target-id-first target ([who] of self-target-id-second - 1)
    ;show [who] of self-target-id-first
  ]
end

to US-DOG-Green-Infantries
  create-infantries Dog-G-inf
	ask infantries with [energy = 0] [
    set color blue
    setxy 130 -30 + random 10
    set heading 180
    set size infantry-size
    set side 1
    ; Properties
    set energy infantry-US-energy
    set frange infantry-US-frange
    set hit infantry-US-hit
    set frange infantry-US-frange
    ; Damage table
    set infantry-damage infantry-US-infantry-damage
    set tank-damage infantry-US-tank-damage
    set artillery-damage infantry-US-artillery-damage
    set bunker-damage infantry-US-bunker-damage
    ; Targets
    set self-target-id-first min-one-of targets [distance myself]
    set self-target-id-second target ([who] of self-target-id-first + 1)
	]
end

to US-DOG-White-Infantries
  create-infantries Dog-W-inf
  ask infantries with [energy = 0] [
    set color blue
    setxy 200 -30 + random 10
    set heading 180
    set size infantry-size
    set side 1
    ; Properties
    set energy infantry-US-energy
    set frange infantry-US-frange
    set hit infantry-US-hit
    set frange infantry-US-frange
    ; Damage table
    set infantry-damage infantry-US-infantry-damage
    set tank-damage infantry-US-tank-damage
    set artillery-damage infantry-US-artillery-damage
    set bunker-damage infantry-US-bunker-damage
    ; Targets
    set self-target-id-first min-one-of targets [distance myself]
    set self-target-id-second target ([who] of self-target-id-first + 1)
	]
end

to US-DOG-Red-Infantries
  create-infantries Dog-R-inf
  ask infantries with [energy = 0] [
    set color blue
    setxy 270 -30 + random 10
    set heading 180
    set size infantry-size
    set side 1
    ; Properties
    set energy infantry-US-energy
    set frange infantry-US-frange
    set hit infantry-US-hit
    set frange infantry-US-frange
    ; Damage table
    set infantry-damage infantry-US-infantry-damage
    set tank-damage infantry-US-tank-damage
    set artillery-damage infantry-US-artillery-damage
    set bunker-damage infantry-US-bunker-damage
    ; Targets
    set self-target-id-first min-one-of targets [distance myself]
    set self-target-id-second target ([who] of self-target-id-first + 1)
	]
end

to US-EASY-Infantries
  create-infantries Easy-inf
  ask infantries with [energy = 0] [
    set color blue
    setxy 390 -30 + random 10
    set heading 180
    set size infantry-size
    set side 1
    ; Properties
    set energy infantry-US-energy
    set frange infantry-US-frange
    set hit infantry-US-hit
    set frange infantry-US-frange
    ; Damage table
    set infantry-damage infantry-US-infantry-damage
    set tank-damage infantry-US-tank-damage
    set artillery-damage infantry-US-artillery-damage
    set bunker-damage infantry-US-bunker-damage
    ; Targets
    set self-target-id-first min-one-of targets [distance myself]
    set self-target-id-second target ([who] of self-target-id-first + 1)
	]
end

to US-FOX-Infantries
  create-infantries Fox-inf
  ask infantries with [energy = 0] [
    set color blue
    setxy 490 -30 + random 10
    set heading 180
    set size infantry-size
    set side 1
    ; Properties
    set energy infantry-US-energy
    set frange infantry-US-frange
    set hit infantry-US-hit
    set frange infantry-US-frange
    ; Damage table
    set infantry-damage infantry-US-infantry-damage
    set tank-damage infantry-US-tank-damage
    set artillery-damage infantry-US-artillery-damage
    set bunker-damage infantry-US-bunker-damage
    ; Targets
    set self-target-id-first min-one-of targets [distance myself]
    set self-target-id-second target ([who] of self-target-id-first + 1)
	]
end

to US-New-Infantries
  US-DOG-Green-Infantries
  US-DOG-White-Infantries
  US-DOG-Red-Infantries
  US-EASY-Infantries
  US-FOX-Infantries
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MISCELLANEOUS
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;to movie
;  vid:start-recorder
;  vid:record-view ;; show the initial state
;  repeat 500 [
;    go
;    vid:record-view
;  ]
;  vid:save-recording "Normandy.mp4"
;end
@#$#@#$#@
GRAPHICS-WINDOW
421
15
1410
550
-1
-1
1.4
1
10
1
1
1
0
0
0
1
0
700
-375
0
1
1
1
ticks
30.0

BUTTON
56
199
122
232
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
57
243
120
276
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

PLOT
18
10
380
183
Troops left
Time
Troop count
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"US troops" 1.0 0 -13791810 true "" "plot count turtles with [side = 1]"
"GE troops" 1.0 0 -2674135 true "" "plot count turtles with [side = 0]"

SLIDER
23
336
197
369
infantry-GE-energy
infantry-GE-energy
1
50
28.0
1
1
NIL
HORIZONTAL

SLIDER
23
428
195
461
infantry-GE-frange
infantry-GE-frange
20
50
43.0
1
1
NIL
HORIZONTAL

SLIDER
23
383
195
416
infantry-GE-hit
infantry-GE-hit
0.1
1
1.0
0.1
1
NIL
HORIZONTAL

SLIDER
215
335
389
368
infantry-US-energy
infantry-US-energy
1
50
30.0
1
1
NIL
HORIZONTAL

SLIDER
217
383
389
416
infantry-US-hit
infantry-US-hit
0.1
1
1.0
0.1
1
NIL
HORIZONTAL

SLIDER
217
429
389
462
infantry-US-frange
infantry-US-frange
50
100
70.0
1
1
NIL
HORIZONTAL

BUTTON
179
202
243
235
NIL
movie
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
21
518
193
551
Tank-Delay
Tank-Delay
0
700
0.0
1
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

boat
false
0
Polygon -1 true false 63 162 90 207 223 207 290 162
Rectangle -6459832 true false 150 32 157 162
Polygon -13345367 true false 150 34 131 49 145 47 147 48 149 49
Polygon -7500403 true true 158 33 230 157 182 150 169 151 157 156
Polygon -7500403 true true 149 55 88 143 103 139 111 136 117 139 126 145 130 147 139 147 146 146 149 55

boat top
true
0
Polygon -7500403 true true 150 1 137 18 123 46 110 87 102 150 106 208 114 258 123 286 175 287 183 258 193 209 198 150 191 87 178 46 163 17
Rectangle -16777216 false false 129 92 170 178
Rectangle -16777216 false false 120 63 180 93
Rectangle -7500403 true true 133 89 165 165
Polygon -11221820 true false 150 60 105 105 150 90 195 105
Polygon -16777216 false false 150 60 105 105 150 90 195 105
Rectangle -16777216 false false 135 178 165 262
Polygon -16777216 false false 134 262 144 286 158 286 166 262
Line -16777216 false 129 149 171 149
Line -16777216 false 166 262 188 252
Line -16777216 false 134 262 112 252
Line -16777216 false 150 2 149 62

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

canon
true
0
Polygon -7500403 true true 75 270 45 120 270 120 240 270 90 270
Rectangle -7500403 true true 135 15 180 150
Line -16777216 false 75 270 45 120
Line -16777216 false 45 120 135 120
Line -16777216 false 135 120 135 15
Line -16777216 false 135 15 180 15
Line -16777216 false 180 15 180 120
Line -16777216 false 180 120 270 120
Line -16777216 false 270 120 240 270
Line -16777216 false 240 270 75 270

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

person soldier
false
0
Rectangle -7500403 true true 127 79 172 94
Polygon -10899396 true false 105 90 60 195 90 210 135 105
Polygon -10899396 true false 195 90 240 195 210 210 165 105
Circle -7500403 true true 110 5 80
Polygon -10899396 true false 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -6459832 true false 120 90 105 90 180 195 180 165
Line -6459832 false 109 105 139 105
Line -6459832 false 122 125 151 117
Line -6459832 false 137 143 159 134
Line -6459832 false 158 179 181 158
Line -6459832 false 146 160 169 146
Rectangle -6459832 true false 120 193 180 201
Polygon -6459832 true false 122 4 107 16 102 39 105 53 148 34 192 27 189 17 172 2 145 0
Polygon -16777216 true false 183 90 240 15 247 22 193 90
Rectangle -6459832 true false 114 187 128 208
Rectangle -6459832 true false 177 187 191 208

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

tank
true
0
Rectangle -7500403 true true 144 0 159 105
Rectangle -6459832 true false 195 45 255 255
Rectangle -16777216 false false 195 45 255 255
Rectangle -6459832 true false 45 45 105 255
Rectangle -16777216 false false 45 45 105 255
Line -16777216 false 45 75 255 75
Line -16777216 false 45 105 255 105
Line -16777216 false 45 60 255 60
Line -16777216 false 45 240 255 240
Line -16777216 false 45 225 255 225
Line -16777216 false 45 195 255 195
Line -16777216 false 45 150 255 150
Polygon -7500403 true true 90 60 60 90 60 240 120 255 180 255 240 240 240 90 210 60
Rectangle -16777216 false false 135 105 165 120
Polygon -16777216 false false 135 120 105 135 101 181 120 225 149 234 180 225 199 182 195 135 165 120
Polygon -16777216 false false 240 90 210 60 211 246 240 240
Polygon -16777216 false false 60 90 90 60 89 246 60 240
Polygon -16777216 false false 89 247 116 254 183 255 211 246 211 237 89 236
Rectangle -16777216 false false 90 60 210 90
Rectangle -16777216 false false 143 0 158 105

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@

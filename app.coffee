Canvas.backgroundColor = '#e0e0e0'

curvemove = 'cubic-bezier(0.4, 0, 0.2, 1)'
isstreammoving = false
fabanimating = 0.5
leftalign = true
gopaste = false
shared = null

wrapper = new Layer width:750,height:1334,backgroundColor: '#000'
scaleratio = Screen.height/1334

wrapper.scale = scaleratio 
wrapper.center()


bgapp = new Layer width:750,height:1334,backgroundColor: '#fff',superLayer: wrapper

msgsA = new Layer
	width: 700
	height: 282
	x:26
	y:350
	image: "images/msgs.png"
	superLayer: bgapp
	
keyboard = new Layer width:750, height: 273*2,y:wrapper.height-273*2,backgroundColor: '#ECEEF1',superLayer: bgapp
searchbox = new Layer
	width: 728, height: 84
	image: "images/searchbox-3.png"	
	superLayer: keyboard
	y:7*2,midX: keyboard.width/2



corpus = new Layer
	width: 710
	height: 56
	image: "images/bottomrow.png"	
	x:14*2,maxY:keyboard.height
	superLayer: keyboard

streams = new PageComponent width:288*2,height:158*2,scrollVertical: false,clip: false,superLayer: keyboard
streams.directionLock = true

if leftalign is false
 streams.x = (wrapper.width/2-100)/2
else
 streams.x = 16
 
streams.midY = keyboard.height/2

cardwrappers = []
cards = []
actions = []
sharings = []
igsas = []
ripples = []
for i in [0...4]
	card = new Layer width:288*2,height:158*2,borderRadius: 4*2,backgroundColor: '',clip: true
	card.image = "images/v3/00"+(i+1)+".png"	

	
	sharing = new Layer
			width:288*2,height:158*2
			superLayer: card
			backgroundColor: ''
	
	ripple = new Layer
			width:400*2,height:400*2
			borderRadius: 200*2
			backgroundColor: 'rgba(66,133,244,0.3)'
			scale:0.5,opacity: 0
			midX: card.width/2
			midY: card.height/2
			superLayer: card
			
	if i < 2
		open = new Layer
				width: 100, height: 80
				superLayer: card
				maxX: card.width
				y:card.height-80
				backgroundColor: ''
	else 	
		open = new Layer
				width: 100, height: 80
				superLayer: card
				maxX: card.width-200
				y:card.height-80
				backgroundColor: ''

	streams.addPage(card)	
	card.x = (card.width+10*2)*i
	streams.updateContent()
	cards.push(card)
	actions.push(open)
	ripples.push(ripple)
	sharings.push(sharing)



streams.on Events.ScrollStart,->
		
		gopaste = false
		unless shared is null
			shared.opacity = 1
		sharebubble.animateStop()
		sharebubble.opacity = 0

[0...sharings.length].map (i) ->
	
	sharings[i].on Events.Click,->
		a = streams.isMoving
		
		unless a is true
			msgalt.opacity = 1
			cards[i].opacity = 0.8
			sharebubble.y = 40
			sharebubble.animate
				properties:
					opacity:1
					y:0
				delay:0.2
				curve:curvemove
				time:0.4
			
			ripples[i].opacity = 1
			ripples[i].scale = 0.5
			ripples[i].animate
				properties:
					scale:1
					opacity:0
				curve:curvemove
				time:0.4
			
			shared = cards[i]


[0...actions.length].map (i) ->
	
	actions[i].on Events.Click,->
		a = streams.isMoving 

		unless a is true
			igsa.image = 'images/gsa/00'+(i+1)+'.png'
			igsa.animate
				properties:
					x:0
				curve:curvemove
				time:0.4
			
			bgapp.animate
				properties:
					scale:0.98
				curve: curvemove
				time:0.4

navbar = new Layer
	width: 750, height: 130
	image: "images/navbar.png"
	superLayer: bgapp
msg = new Layer
	width: 750, height: 98
	image: "images/imsg.png"
	y:keyboard.y-98
	superLayer: bgapp
msgalt = new Layer
	width: 750, height: 200
	image: "images/msg-alt2.png"
	y:keyboard.y-200
	superLayer: bgapp
	opacity:0

for i in [0...4]

	igsa = new Layer
		width: 750, height: 1334
		image: "images/gsa/00"+(i+1)+".png"
	
	igsa.originX = 0
	igsa.originY = 0
	igsa.x = 750
	igsa.superLayer = wrapper
	
	igsas.push(igsa)

[0...cards.length].map (i) ->

	igsas[i].on Events.Click,->
		
		bgapp.animate
			properties:
				scale:1
			curve: curvemove
			time:0.4
		
		igsas[i].animate
			properties:
				x:750
			curve: curvemove
			time: 0.4


streams.x = wrapper.width

keybg = new Layer
	width:keyboard.width,height:keyboard.height-60*2,y:60*2
	backgroundColor: '#ECEFF0'
	superLayer: keyboard
keycap = new Layer
	width: 734, height: 406
	image: "images/kbd.png"
	superLayer: keybg
	midX: wrapper.width/2

corpus.on Events.Click,->
	
	keybg.y = 60*2
	keybg.opacity = 1
	msgalt.opacity = 0
	
	streams.x = wrapper.width
	streams.opacity = 0
	sharebubble.opacity = 0 
	unless shared is null
		shared.opacity = 1

keybg.on Events.Click,->
	keybg.animate
		properties:
			opacity: 0
		curve: curvemove
		time:0.2

	streams.scrollToPoint(x:0,y:0,false)

	Utils.delay 0.2,-> 
		keybg.y = wrapper.height
	streams.animate
		properties:
			x:10*2
			opacity:1
		curve: curvemove
		time:0.3
	
		
sharebubble = new Layer
	width: 380, height: 174
	image: "images/sharebubble.png"
	superLayer: keyboard
	x:46*2
	opacity: 0



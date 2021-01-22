/obj/structure/chezh_hangehog
	name = "Tank trap"
	desc = "An obstacle defense made of metal angle beams."
	icon = 'icons/obj/structures.dmi'
	icon_state = "tank_trap"
	anchored = 1
	density = 1
	throwpass = 0
	layer = OBJ_LAYER + 0.1
	flags = OBJ_CLIMBABLE


/obj/structure/chezh_hangehog/New()
	..()
	flags |= ON_BORDER

/obj/structure/chezh_hangehog/Destroy()
	..()

/obj/structure/chezh_hangehog/proc/check4struct(mob/user as mob)
	if((locate(/obj/structure/chezh_hangehog) || \
		locate(/obj/structure/sandbag) || \
		locate(/obj/structure/brutswehr)|| \
		locate(/obj/structure/sandbag/concrete_block)) in src.loc.contents \
		)
		to_chat(user, "\red There is no more space.")
		return 0
	return 1

/obj/structure/chezh_hangehog/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(istype(mover, /obj/item/projectile))
		var/obj/item/projectile/proj = mover

		if(proj.firer && Adjacent(proj.firer))
			return 1

		if (get_dist(proj.starting, loc) <= 1)//allows to fire from 1 tile away of sandbag
			return 1

		return 1

	return 0

/obj/structure/chezh_hangehog/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/wrench))
		check4struct(user)
		if(!anchored)
			to_chat(user, "<span class='notice'>You start wrenching the [src].</span>")
			if(do_after(user, 20, src))
				playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
				anchored = TRUE
				to_chat(user, "<span class='notice'>You wrenched the [src].</span>")
		else
			to_chat(user, "<span class='notice'>You start unwrenching the [src].</span>")
			if(do_after(user, 20, src))
				playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
				anchored = FALSE
				to_chat(user, "<span class='notice'>You unwrenched the [src].</span>")

/obj/structure/chezh_hangehog/ex_act(severity)
	switch(severity)
		if(1.0)
			new /obj/item/stack/rods(src.loc)
			new /obj/item/stack/rods(src.loc)
			new /obj/item/stack/rods(src.loc)
			qdel(src)
			return
		if(2.0)
			new /obj/item/stack/rods(src)
			new /obj/item/stack/rods(src)
			qdel(src)
			return
		else
	return
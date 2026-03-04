hsp = lerp(hsp, 0, friccion);
vsp = lerp(vsp, 0, friccion);

x += hsp;
y += vsp;

if (hp <= 0) {
    instance_destroy();
}
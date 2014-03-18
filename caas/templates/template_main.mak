## -*- coding: utf-8 -*-

<%inherit file="caas:templates/template_base.mak"/>

<script type="text/javascript">
$(window).load( function resizeImg() {
    var thisImg= $('.cont');
    var refH = thisImg.height();
    var refW = thisImg.width();
    var refRatio = refW/refH;
    var imgH = thisImg.children("img").height();
    var imgW = thisImg.children("img").width();
    alert($(window).width());
    if ( (imgW/imgH) > refRatio ) { 
        thisImg.addClass("portrait");
        thisImg.removeClass("landscape");
    } else {
        thisImg.addClass("landscape");
        thisImg.removeClass("portrait");
    }
});
</script>

% if auth:
<a href="${request.route_url('logout')}">Logout</a>
<a href="${request.route_url('home')}">Discuss</a>
% else:
<a href="${request.route_url('login')}">Login</a>
% endif
   <p class="text-justify bg-info">
   ${message}
   </p>

<div class="container">
    <div class="row">
	<div class="col-md-8 col-md-offset-2" align='justify'>
	<p align=justify>Большинство наших граждан, выезжающих в США, сильно ограничены по времени (деловые поездки, 
	конференции) или по возможностям. Популярные программы Work and travel in USA обычно раскрывают только сторону 
	"Work", и их участники сильно зажаты контрактными обязательствами. Получить туристическую визу в США совсем не 
	просто, так что дикарем туда не нагрянешь. Отдыхательные поездки в Америку, как правило, могут себе позволить 
	только люди с приличным достатком или связями, и эти поездки в основном ограничиваются пляжами Флориды или 
	Калифорнии. Тем не менее, красоты континентальной Америки заслуживают не меньшего внимания и отнюдь не 
	ограничиваются Ниагарским водопадом, Большим каньоном и Уеллоустонским национальным парком.</p>
<!--
    <div class="Collage">    
       	<img src="http://placehold.it/300x200">
	<img src="http://placehold.it/300x200">
	<img src="http://placehold.it/200x70">



<img src="http://caas.ru/utah/Arches_1_small.jpg"><img src="http://caas.ru/utah/Arches_2_small.jpg">
   </div>
-->

<p align=justify>Протекающие в этой местности процессы выветривания и речной эрозии образуют в песчаниках и 
сланцах глубокие, порой многоярусные, каньоны, и многочисленные причудливые останцы. Пустынный пояс также охватывает 
штаты Колорадо, Аризону, Неваду и Нью-Мексико и исключительно богат на красоты, а, следовательно, и на национальные 
парки. В этой же местности располагается хорошо известный Большой Каньон и множество других любопытностей.</p>
<div class="cont">
<img alt="Title 1" src="http://caas.ru/utah/Arches_5_small.jpg"/><img alt="Title 2" src="http://caas.ru/utah/Arches_6_small.jpg"/><img alt="Title 3" src="http://caas.ru/utah/Arches_7_small.jpg"/>
</div>
<p align=justify><i>Что смотреть и что вообще делать.</i> По приезде в национальный парк на КПП вы получаете пермит.
Цена пермита на посещение национальных парков во всех штатах одинаковая и весьма умеренная - 10$ за машинонеделю, то 
есть, платите не за каждого пассажира, а за всех, кто есть в машине. На следующий день в машину можно набить другой 
народ и пермит будет действовать и на них. Таким образом в парке можно неограниченной толпой тусоваться неделю за 
10$. Пермит на кемпинг отдельный и тоже, вроде, не существенный, типа 7,5$ за палатконеделю. Кроме пермита Вам 
дадут описания трэйлов, еще какие-то полезные бумажки и 
<a href="http://www.utah.com/nationalparks/zion/ZION-map.pdf">карту</a>. И так во всех национальных парках Юты</p>

        </div>
    </div>
</div>
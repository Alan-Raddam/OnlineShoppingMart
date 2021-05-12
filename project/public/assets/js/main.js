(function ($) {
    "use strict";

    /*****************************
     * Commons Variables
     *****************************/
    var $window = $(window),
        $body = $('body');

    /**********************
     * Sticky Menu
     ***********************/
    $(window).on('scroll', function (event) {
        var scroll = $(window).scrollTop();
        if (scroll < 350) {
            $(".sticky-header").removeClass("is-sticky");
        } else {
            $(".sticky-header").addClass("is-sticky");
        }
    });

    /**********************
     * Popup Search
     ***********************/
    $(".popup__search-box").on('click', function () {
        $(".header__popup-search-form").slideToggle("slow");
    });

    /**********************
     * Popup Expand Menu
     ***********************/
    $(".popup-expand-menu-button").on('click', function () {
        $(".popup-expand-menu").slideToggle("slow");
        $(".header__middle, .header__color--silver.is-sticky").toggleClass("white-bg");
        $(".popup-expand-menu-button i").toggleClass("black-color");
        $(".popup-expand-menu-button i").toggleClass("ion-ios-close-empty");
        $(".header__user-action-icon i").toggleClass("black-color");
        $(".header__popup-search-form i").toggleClass("white-color");
        $(".header__logo-img").toggleClass("color-invert");
        $(".internal-link").toggleClass("black-color");
    });

    $(".card-header").on('click', function () {
        $(".card-header").removeClass("show");

        $(".card-header").addClass("show");
    });

    /*****************************
     * Off Canvas Function
     *****************************/
    (function () {
        var $offCanvasToggle = $('.offcanvas-toggle'),
            $offCanvas = $('.offcanvas'),
            $offCanvasOverlay = $('.offcanvas-overlay'),
            $mobileMenuToggle = $('.mobile-menu-toggle');
        $offCanvasToggle.on('click', function (e) {
            e.preventDefault();
            var $this = $(this),
                $target = $this.attr('href');
            $body.addClass('offcanvas-open');
            $($target).addClass('offcanvas-open');
            $offCanvasOverlay.fadeIn();
            if ($this.parent().hasClass('mobile-menu-toggle')) {
                $this.addClass('close');
            }
        });
        $('.offcanvas-close, .offcanvas-overlay').on('click', function (e) {
            e.preventDefault();
            $body.removeClass('offcanvas-open');
            $offCanvas.removeClass('offcanvas-open');
            $offCanvasOverlay.fadeOut();
            $mobileMenuToggle.find('a').removeClass('close');
        });
    })();


    /**************************
     * Offcanvas: Menu Content
     **************************/
    function mobileOffCanvasMenu() {
        var $offCanvasNav = $('.offcanvas-menu'),
            $offCanvasNavSubMenu = $offCanvasNav.find('.sub-menu');

        /*Add Toggle Button With Off Canvas Sub Menu*/
        $offCanvasNavSubMenu.parent().prepend('<span class="offcanvas__menu-expand"></span>');

        /*Category Sub Menu Toggle*/
        $offCanvasNav.on('click', 'li a, .offcanvas__menu-expand', function (e) {
            var $this = $(this);
            if ($this.attr('href') === '#' || $this.hasClass('offcanvas__menu-expand')) {
                e.preventDefault();
                if ($this.siblings('ul:visible').length) {
                    $this.parent('li').removeClass('active');
                    $this.siblings('ul').slideUp();
                    $this.parent('li').find('li').removeClass('active');
                    $this.parent('li').find('ul:visible').slideUp();
                } else {
                    $this.parent('li').addClass('active');
                    $this.closest('li').siblings('li').removeClass('active').find('li').removeClass('active');
                    $this.closest('li').siblings('li').find('ul:visible').slideUp();
                    $this.siblings('ul').slideDown();
                }
            }
        });
    }

    mobileOffCanvasMenu();

    /***************8
     * 商品详情页
     */
    $("a#add_to_cart").click(function () {
        var quantity = $("input#quantity").val()
        if (quantity == null)
            quantity = 1;
        $.post("/cartitems",
            {
                cartitem: {
                    productid: $(this).attr('from'),
                    quantity: quantity
                },
            },
            function (data, status) {
                console.log(data);
                console.log(status);
                $("div#shopping_list_quickview").empty();
                $("h5#add_cart_status").html('所选商品已经成功添加到购物购物车');
                $("span#number").html('你的购物车中共有' + data.length + '种商品');
                var totalprice = 0.0;
                data.forEach(function (item) {
                    totalprice += item.price * item.quantity;
                    $("div#shopping_list_quickview").prepend('\
                                <div class="row">\
                                    <div class="col-md-6">\
                                        <div class="modal__product-img">\
                                            <img class="img-fluid" src=' + item.image_directory.url + ' alt="">\
                                        </div>\
                                    </div>\
                                    <div class="col-md-6">\
                                        <span class="modal__product-title">' + item.name + '</span>\
                                        <span class="modal__product-price m-tb-15">¥' + item.price + '</span>\
                                        <ul class="modal__product-info ">\
                                            <li>购买数量:<span>' + item.quantity + '</span></li>\
                                        </ul>\
                    '
                    )
                });
                $("span#price").html('¥' + totalprice);
                $("span#shipping").html('¥' + 0.00);
                $("span#total").html('¥' + totalprice)
            });
    })

    /*
    购物车页面
     */

    $(".cartitem_change_quantity").bind('change', function () {
        $.post("/cartitems/" + this.id,
            {
                _method: 'patch',
                cartitem: {
                    quantity: $("#" + this.id).val()
                },
            },
            function (data, status) {
                console.log(data);
                console.log(status);
            });
    });

    /*
    提交订单页面
     */
    $("button#create_order").click(function () {
        $.post("/transaction_orders/",
            {
                transaction_order: {
                    name: $("input#form-name").val(),
                    address: $("input#form-address").val(),
                    phone: $("input#form-phone").val(),
                    postcode: $("input#form-postcode").val(),
                    email: $("input#form-email").val(),
                    note: $("input#form-additional-info").val(),
                },
            },
            function (data, status) {
                console.log(data);
                console.log(status);
            });
    })


    /*********
     * 全局更改喜欢（收藏）状态函数，要求button的命名为
     */


    $('i.ion-android-favorite-outline.reverse-fav').on("click", function () {
        $.post("/favorites/reverse",
            {
                product_id: $(this).attr('from')
            },
            function (data, status) {
                console.log(data);
                console.log(status);
            })
    })
    $('button.reverse-fav').click(function () {
        alert("succeed!");
        $.post("/favorites/reverse",
            {
                product_id: $(this).attr('from')
            },
            function (data, status) {
                console.log(data);
                console.log(status);
            })
    })


    /**********************
     * Vertical Menu
     ***********************/
    $('.header-menu-vertical .menu-title').on('click', function (event) {
        $('.header-menu-vertical .menu-content').slideToggle(500);
    });

    $('.menu-content').each(function () {
        var $ul = $(this),
            $lis = $ul.find('.menu-item:gt(7)'),
            isExpanded = $ul.hasClass('expanded');
        $lis[isExpanded ? 'show' : 'hide']();

        if ($lis.length > 0) {
            $ul
                .append($('<li class="expand">' + (isExpanded ? '<a href="javascript:;"><span><i class="icon-minus-square"></i>Close Categories</span></a>' : '<a href="javascript:;"><span><i class="icon-plus-square"></i>More Categories</span></a>') + '</li>')
                    .on('click', function (event) {
                        var isExpanded = $ul.hasClass('expanded');
                        event.preventDefault();
                        $(this).html(isExpanded ? '<a href="javascript:;"><span><i class="icon-plus-square"></i>More Categories</span></a>' : '<a href="javascript:;"><span><i class="icon-minus-square"></i>Close Categories</span></a>');
                        $ul.toggleClass('expanded');
                        $lis.toggle(300);
                    }));
        }
    });

    /*****************************
     * Category more toggle
     *****************************/

    $(".category-menu li.hidden").hide();
    $("#more-btn").on('click', function (e) {

        e.preventDefault();
        $(".category-menu li.hidden").toggle(500);
        var htmlAfter = '<i class="ion-ios-minus-empty" aria-hidden="true"></i> Less Categories';
        var htmlBefore = '<i class="ion-ios-plus-empty" aria-hidden="true"></i> More Categories';


        if ($(this).html() == htmlBefore) {
            $(this).html(htmlAfter);
        } else {
            $(this).html(htmlBefore);
        }
    });

    /**********************
     * Hero Slider - [Single Grid]
     ***********************/
    $('.hero').slick({
        arrows: true,
        fade: true,
        dots: true,
        easing: 'linear',
        speed: 2000,
        prevArrow: '<button type="button" class="hero-slider__arrow hero-slider__arrow--left"><i class="fal fa-chevron-left"></i></button>',
        nextArrow: '<button type="button" class="hero-slider__arrow hero-slider__arrow--right"><i class="fal fa-chevron-right"></i></button>',
        responsive: [

            {
                breakpoint: 992,
                settings: {
                    arrows: false,
                }
            },
            {
                breakpoint: 993,
                settings: {
                    arrows: true,
                }
            }
        ]
    });


    /************************************************
     * Product Slider - Style: Default [5 Grid, 2 Rows]
     ***********************************************/
    $('.product-default-slider-5grid-2rows').slick({
        arrows: true,
        infinite: false,
        slidesToShow: 5,
        rows: 2,
        slidesToScroll: 1,
        easing: 'ease-out',
        speed: 1000,
        prevArrow: '<button type="button" class="default-slider__arrow default-slider__arrow--left prevArrow"><i class="ion-ios-arrow-thin-left"></i></button>',
        nextArrow: '<button type="button"  class="default-slider__arrow default-slider__arrow--right nextArrow"><i class="ion-ios-arrow-thin-right"></i></button>',
        responsive: [

            {
                breakpoint: 1470,
                settings: {
                    slidesToShow: 4
                }
            },
            {
                breakpoint: 992,
                settings: {
                    slidesToShow: 3,
                }
            },
            {
                breakpoint: 768,
                settings: {
                    slidesToShow: 2,
                    arrows: false,
                    autoplay: true,
                    infinite: true,
                }
            },
            {
                breakpoint: 480,
                settings: {
                    slidesToShow: 1,
                    arrows: false,
                    autoplay: true,
                    infinite: true,
                }
            }
        ]
    });

    /************************************************
     * Product Slider - Style: Default [4 Grid, 1 Rows]
     ***********************************************/
    $('.product-default-slider-4grid-1rows').slick({
        arrows: true,
        infinite: false,
        slidesToShow: 4,
        slidesToScroll: 1,
        rows: 1,
        easing: 'ease-out',
        speed: 1000,
        prevArrow: '<button type="button" class="default-slider__arrow default-slider__arrow--left prevArrow"><i class="ion-ios-arrow-thin-left"></i></button>',
        nextArrow: '<button type="button"  class="default-slider__arrow default-slider__arrow--right nextArrow"><i class="ion-ios-arrow-thin-right"></i></button>',
        responsive: [

            {
                breakpoint: 992,
                settings: {
                    slidesToShow: 3,
                }
            },
            {
                breakpoint: 768,
                settings: {
                    slidesToShow: 2,
                    arrows: false,
                    autoplay: true,
                    infinite: true,
                }
            },
            {
                breakpoint: 480,
                settings: {
                    slidesToShow: 1,
                    arrows: false,
                    autoplay: true,
                    infinite: true,
                }
            }
        ]
    });

    /************************************************
     * Product Slider - Style: Default [3 Grid, 1 Rows]
     ***********************************************/
    $('.product-default-slider-3grid-1rows').slick({
        arrows: true,
        infinite: false,
        slidesToShow: 3,
        slidesToScroll: 1,
        rows: 1,
        easing: 'ease-out',
        speed: 1000,
        prevArrow: '<button type="button" class="default-slider__arrow default-slider__arrow--left prevArrow"><i class="ion-ios-arrow-thin-left"></i></button>',
        nextArrow: '<button type="button"  class="default-slider__arrow default-slider__arrow--right nextArrow"><i class="ion-ios-arrow-thin-right"></i></button>',
        responsive: [

            {
                breakpoint: 992,
                settings: {
                    slidesToShow: 3,
                }
            },
            {
                breakpoint: 768,
                settings: {
                    slidesToShow: 2,
                    arrows: false,
                    autoplay: true,
                    infinite: true,
                }
            },
            {
                breakpoint: 480,
                settings: {
                    slidesToShow: 1,
                    arrows: false,
                    autoplay: true,
                    infinite: true,
                }
            }
        ]
    });
    /************************************************
     * Product Slider - Style: Default with Banner [3 Grid, 1 Rows]
     ***********************************************/
    $('.product-default-slider-banner-3grid-1rows').slick({
        arrows: true,
        infinite: false,
        slidesToShow: 3,
        slidesToScroll: 1,
        rows: 1,
        easing: 'ease-out',
        speed: 1000,
        prevArrow: '<button type="button" class="default-slider__arrow default-slider__arrow--left prevArrow"><i class="ion-ios-arrow-thin-left"></i></button>',
        nextArrow: '<button type="button"  class="default-slider__arrow default-slider__arrow--right nextArrow"><i class="ion-ios-arrow-thin-right"></i></button>',
        responsive: [

            {
                breakpoint: 1200,
                settings: {
                    slidesToShow: 2,
                }
            },
            {
                breakpoint: 992,
                settings: {
                    slidesToShow: 3,
                }
            },
            {
                breakpoint: 768,
                settings: {
                    slidesToShow: 2,
                    arrows: false,
                    autoplay: true,
                    infinite: true,
                }
            },
            {
                breakpoint: 480,
                settings: {
                    slidesToShow: 1,
                    arrows: false,
                    autoplay: true,
                    infinite: true,
                }
            }
        ]
    });

    /************************************************
     * Product Slider - Style: Segment [1 Grid, 3 Rows]
     ***********************************************/
    $('.product-segment-slider-1grid-3rows').slick({
        arrows: false,
        dots: true,
        infinite: false,
        slidesToShow: 1,
        rows: 3,
        slidesToScroll: 1,
        easing: 'linear',
        speed: 500,

        responsive: [

            {
                breakpoint: 1470,
                settings: {
                    slidesToShow: 1
                }
            },
            {
                breakpoint: 992,
                settings: {
                    slidesToShow: 2
                }
            },

            {
                breakpoint: 640,
                settings: {
                    slidesToShow: 1
                }
            }
        ]
    });

    /************************************************
     * Product Slider - Style: Segment [3 Grid, 3 Rows]
     ***********************************************/
    $('.product-segment-slider-3grid-3rows').slick({
        arrows: true,
        dots: false,
        infinite: false,
        slidesToShow: 3,
        rows: 3,
        slidesToScroll: 1,
        easing: 'linear',
        speed: 500,
        prevArrow: '<button type="button" class="default-slider__arrow default-slider__arrow--left prevArrow"><i class="ion-ios-arrow-thin-left"></i></button>',
        nextArrow: '<button type="button"  class="default-slider__arrow default-slider__arrow--right nextArrow"><i class="ion-ios-arrow-thin-right"></i></button>',
        responsive: [
            {
                breakpoint: 992,
                settings: {
                    slidesToShow: 2
                }
            },

            {
                breakpoint: 768,
                settings: {
                    slidesToShow: 2,
                    arrows: false,
                    autoplay: true,
                    infinite: true,
                }
            },

            {
                breakpoint: 640,
                settings: {
                    slidesToShow: 1,
                    arrows: false,
                    autoplay: true,
                    infinite: true,
                }
            }
        ]
    });


    /************************************************
     * Blog Slider - Style: Feed [3 Grid, 1 Rows]
     ***********************************************/
    $('.blog-feed-slider-3grid').slick({
        arrows: true,
        infinite: false,
        slidesToShow: 3,
        slidesToScroll: 1,
        easing: 'linear',
        speed: 1000,
        prevArrow: '<button type="button" class="default-slider__arrow default-slider__arrow--left prevArrow"><i class="ion-ios-arrow-thin-left"></i></button>',
        nextArrow: '<button type="button"  class="default-slider__arrow default-slider__arrow--right nextArrow"><i class="ion-ios-arrow-thin-right"></i></button>',
        responsive: [

            {
                breakpoint: 1470,
                settings: {
                    slidesToShow: 3
                }
            },
            {
                breakpoint: 992,
                settings: {
                    slidesToShow: 2,
                }
            },
            {
                breakpoint: 768,
                settings: {
                    arrows: false,
                    slidesToShow: 2,
                    autoplay: true,
                }
            },
            {
                breakpoint: 480,
                settings: {
                    slidesToShow: 1,
                    arrows: false,
                    autoplay: true,
                }
            }
        ]
    });
    /************************************************
     * Company logo Slider
     ***********************************************/
    $('.company-logo__area').slick({
        arrows: false,
        infinite: true,
        slidesToShow: 7,
        slidesToScroll: 1,
        easing: 'linear',
        speed: 1000,
        responsive: [
            {
                breakpoint: 1440,
                settings: {
                    slidesToShow: 6
                }
            },
            {
                breakpoint: 1200,
                settings: {
                    slidesToShow: 5
                }
            },
            {
                breakpoint: 992,
                settings: {
                    slidesToShow: 4
                }
            },
            {
                breakpoint: 768,
                settings: {
                    slidesToShow: 3
                }
            },
            {
                breakpoint: 480,
                settings: {
                    slidesToShow: 2
                }
            }
        ]
    });

    /***********************************
     * Gallery - Horizontal
     ************************************/
    $('.product-image--large-horizontal').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: false,
        fade: true,
    });
    $('.product-image--thumb-horizontal').slick({
        slidesToShow: 4,
        slidesToScroll: 1,
        prevArrow: '<button type="button" class="gallery__nav gallery__nav-horizontal gallery__nav-horizontal--left prevArrow"><i class="fas fa-chevron-left"></i></button>',
        nextArrow: '<button type="button"  class="gallery__nav gallery__nav-horizontal gallery__nav-horizontal--right nextArrow"><i class="fas fa-chevron-right"></i></button>'
    });
    /***********************************
     * Gallery - Vertical
     ************************************/
    $('.product-image--large-vertical').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: false,
        fade: true,
    });
    $('.product-image--thumb-vertical').slick({
        slidesToShow: 4,
        slidesToScroll: 1,
        vertical: true,
        focusOnSelect: true,
        prevArrow: '<button type="button" class="gallery__nav gallery__nav-vertical gallery__nav-vertical--up prevArrow"><i class="fas fa-chevron-up"></i></button>',
        nextArrow: '<button type="button"  class="gallery__nav gallery__nav-vertical gallery__nav-vertical--down nextArrow"><i class="fas fa-chevron-down"></i></button>'
    });
    /***********************************
     * Gallery - Slider
     ************************************/
    $('.product-gallery-box--single-slider').slick({
        slidesToShow: 4,
        slidesToScroll: 1,
        focusOnSelect: true,
        arrows: true,
        prevArrow: '<button type="button" class="gallery__nav gallery__nav-horizontal gallery__nav-horizontal--left prevArrow"><i class="fas fa-chevron-left"></i></button>',
        nextArrow: '<button type="button"  class="gallery__nav gallery__nav-horizontal gallery__nav-horizontal--right nextArrow"><i class="fas fa-chevron-right"></i></button>',
        responsive: [

            {
                breakpoint: 992,
                settings: {
                    slidesToShow: 3,
                }
            },
            {
                breakpoint: 768,
                settings: {
                    slidesToShow: 2,
                    arrows: false,
                    autoplay: true,
                    infinite: true,
                }
            },
            {
                breakpoint: 480,
                settings: {
                    slidesToShow: 1,
                    arrows: false,
                    autoplay: true,
                    infinite: true,
                }
            }
        ]
    });

    /***********************************
     * Modal  Quick View Image
     ************************************/
    $('.modal-product-image--large').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: false,
        fade: true,
        asNavFor: '.modal-product-image--thumb'
    });
    $('.modal-product-image--thumb').slick({
        slidesToShow: 4,
        slidesToScroll: 1,
        asNavFor: '.modal-product-image--large',
        focusOnSelect: true,
        prevArrow: '<button type="button" class="gallery__nav gallery__nav-horizontal gallery__nav-horizontal--left prevArrow"><i class="fas fa-chevron-left"></i></button>',
        nextArrow: '<button type="button"  class="gallery__nav gallery__nav-horizontal gallery__nav-horizontal--right nextArrow"><i class="fas fa-chevron-right"></i></button>'
    });
    $('.modal').on('shown.bs.modal', function (e) {
        $('.modal-product-image--large, .modal-product-image--thumb').slick('setPosition');
        $('.product-gallery-box').addClass('open');
    });

    /***********************************
     * Blog Image Slider
     ************************************/
    $('.inner-slider-grid-1').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        focusOnSelect: true,
        arrows: true,
        prevArrow: '<button type="button" class="inner-slider__arrow inner-slider__arrow--left prevArrow"><i class="far fa-chevron-left"></i></button>',
        nextArrow: '<button type="button"  class="inner-slider__arrow inner-slider__arrow--right nextArrow"><i class="far fa-chevron-right"></i></button>',
    });

    /***********************************
     * Team Slider
     ************************************/
    $('.inner-slider-grid-4').slick({
        slidesToShow: 4,
        slidesToScroll: 1,
        focusOnSelect: true,
        arrows: true,
        prevArrow: '<button type="button" class="inner-slider__arrow inner-slider__arrow--left prevArrow"><i class="far fa-chevron-left"></i></button>',
        nextArrow: '<button type="button"  class="inner-slider__arrow inner-slider__arrow--right nextArrow"><i class="far fa-chevron-right"></i></button>',
        responsive: [

            {
                breakpoint: 992,
                settings: {
                    slidesToShow: 3,
                }
            },
            {
                breakpoint: 768,
                settings: {
                    slidesToShow: 2,
                }
            },
            {
                breakpoint: 576,
                settings: {
                    slidesToShow: 1,
                }
            }
        ]
    });

    /**********************
     * Price Range
     ***********************/
    $("#slider-range").slider({
        range: true,
        orientation: "horizontal",
        min: 0,
        max: 1000,
        values: [0, 1000],
        step: 100,

        slide: function (event, ui) {
            if (ui.values[0] == ui.values[1]) {
                return false;
            }

            $("#min_price").val(ui.values[0]);
            $("#max_price").val(ui.values[1]);
        }
    });


    /******************************************************
     *  Product Gallery - Image Zoom
     ******************************************************/
    $("#img-zoom").elevateZoom({
        gallery: "gallery-zoom",
        galleryActiveClass: "zoom-active",
        constrainSize: 274,
        zoomType: "lens",
        containLensZoom: true,
    });


    /*******************
     * Video Popup
     *******************/
    $('.vinobox-popup').venobox();


    /*****************************
     *   Countdown
     **************************** */
    $('[data-countdown]').each(function () {
        var $this = $(this),
            finalDate = $(this).data('countdown');
        $this.countdown(finalDate, function (event) {
            $this.html(event.strftime('<span class="cdown day">%-D <p>Days</p></span> <span class="cdown hour">%-H <p>Hours</p></span> <span class="cdown minutes">%M <p>Mins</p></span> <span class="cdown second">%S <p>Sec</p></span>'));
        });
    });

    /*****************************
     * Create an account toggle
     *****************************/
    $(".creat-account").on("click", function () {
        $(".open-create-account").slideToggle(1000);
    });

    $(".shipping-account").on("click", function () {
        $(".open-shipping-account").slideToggle(1000);
    });


    /****************************
     * Password Hide/ Show Toggle
     *****************************/
    $(".password__toggle--btn").click(function () {

        $(this).toggleClass("fa-eye fa-eye-slash");
        var input = $($(this).attr("data-toggle"));
        if (input.attr("type") == "password") {
            input.attr("type", "text");
        } else {
            input.attr("type", "password");
        }
    });

    /****************************
     * Accordian - FAQ
     *****************************/
    const accordianItemHeaders = document.querySelectorAll(".accordian-item-header");

    accordianItemHeaders.forEach(accordianItemHeader => {
        accordianItemHeader.addEventListener("click", () => {
            const current = document.querySelector(".accordian-item-header.active");

            if (current && current !== accordianItemHeader) {
                current.classList.toggle("active");
                current.nextElementSibling.style.maxHeight = 0;
            }
            accordianItemHeader.classList.toggle("active");

            const accordianItemBody = accordianItemHeader.nextElementSibling;

            if (accordianItemHeader.classList.contains("active")) {
                accordianItemBody.style.maxHeight = accordianItemBody.scrollHeight + "px";
            } else {
                accordianItemBody.style.maxHeight = 0;
            }
        });
    });


    /*----------------------------------
        Scroll To Top Active
    -----------------------------------*/
    $('body').materialScrollTop();

})
(jQuery);

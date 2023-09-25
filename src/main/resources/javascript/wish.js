$(document).ready(function(){
    $(".wish-icon i").click(function(){
        $(this).toggleClass("fa-heart fa-heart-o");
    });
});


function generateStarRating(rating) {
    // Ensure the rating is within the valid range (0 to 5)
    if (rating < 0) {
        rating = 0;
    } else if (rating > 5) {
        rating = 5;
    }

    // Create an HTML string for the star rating display
    let starRatingHtml = '<div class="star-rating">';

    // Fill in the full stars
    for (let i = 1; i <= rating; i++) {
        starRatingHtml += '<i class="fa fa-star"></i>';
    }

    // Fill in the empty stars
    for (let i = rating + 1; i <= 5; i++) {
        starRatingHtml += '<i class="fa fa-star-o"></i>';
    }

    starRatingHtml += '</div>';

    return starRatingHtml;
}
package org.jahia.se.modules.dummyjson.model;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.ObjectCodec;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.deser.std.StdDeserializer;

import com.fasterxml.jackson.databind.type.CollectionType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


public class ProductDeserializer extends StdDeserializer<Product> {

    private static Logger logger = LoggerFactory.getLogger(ProductDeserializer.class);

    private static final String PRODUCT_ID = "/id";
    private static final String PRODUCT_TITLE = "/title";
    private static final String PRODUCT_DESCRIPTION = "/description";
    private static final String PRODUCT_PRICE = "/price";
    private static final String PRODUCT_DISCOUNTPERCENTAGE = "/discountPercentage";
    private static final String PRODUCT_RATING = "/rating";
    private static final String PRODUCT_STOCK = "/stock";
    private static final String PRODUCT_BRAND = "/brand";
    private static final String PRODUCT_CATEGORY = "/category";
    private static final String PRODUCT_THUMBNAIL = "/thumbnail";
    private static final String PRODUCT_IMAGES = "/images";

    public ProductDeserializer() {
        this(null);
    }

    public ProductDeserializer(Class<?> vc) {
        super(vc);
    }

    @Override
    public Product deserialize(JsonParser jsonParser, DeserializationContext deserializationContext)
            throws IOException, JsonProcessingException {

        ObjectCodec oc = jsonParser.getCodec();
        JsonNode productNode = oc.readTree(jsonParser);
        Product productAsset = new Product();

        JsonNode productId = productNode.at(PRODUCT_ID);
        productAsset.setId(productId.intValue());
        JsonNode productTitle = productNode.at(PRODUCT_TITLE);
        productAsset.setTitle(productTitle.textValue());
        JsonNode productDescription = productNode.at(PRODUCT_DESCRIPTION);
        productAsset.setDescription(productDescription.textValue());
        JsonNode productPrice = productNode.at(PRODUCT_PRICE);
        productAsset.setPrice(productPrice.doubleValue());
        JsonNode productDiscountPercentage = productNode.at(PRODUCT_DISCOUNTPERCENTAGE);
        productAsset.setDiscountPercentage(productDiscountPercentage.doubleValue());
        JsonNode productRating = productNode.at(PRODUCT_RATING);
        productAsset.setRating(productRating.doubleValue());
        JsonNode productStock = productNode.at(PRODUCT_STOCK);
        productAsset.setStock(productStock.intValue());
        JsonNode productBrand = productNode.at(PRODUCT_BRAND);
        productAsset.setBrand(productBrand.textValue());
        JsonNode productCategory = productNode.at(PRODUCT_CATEGORY);
        productAsset.setCategory(productCategory.textValue());
        JsonNode productThumbnail = productNode.at(PRODUCT_CATEGORY);
        productAsset.setThumbnail(productThumbnail.textValue());
        ObjectMapper objectMapper = new ObjectMapper();
        // Define the type of the collection you want (List of Strings in this case)
        CollectionType listType = objectMapper.getTypeFactory().constructCollectionType(List.class, String.class);
        String jsonArray = productNode.at(PRODUCT_IMAGES).toString();
        // Convert the JSON array to a List
        List<String> stringList = objectMapper.readValue(jsonArray, listType);
        productAsset.setImages(stringList);

        return productAsset;
    }
}


package org.jahia.se.modules.dummyjson.model;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.deser.std.StdDeserializer;

import java.io.IOException;

public class ProductDeserializer extends StdDeserializer<Product> {

    public ProductDeserializer() {
        this(null);
    }

    public ProductDeserializer(Class<?> vc) {
        super(vc);
    }

    @Override
    public Product deserialize(JsonParser jp, DeserializationContext ctxt)
            throws IOException, JsonProcessingException {
        JsonNode node = jp.getCodec().readTree(jp);

        String id = node.get("id").textValue();
        String title = node.get("title").textValue();
        String description = node.get("description").textValue();
        String price = node.get("price").textValue();
        String discountPercentage = node.get("discountPercentage").textValue();
        String rating = node.get("rating").textValue();
        String stock = node.get("stock").textValue();
        String brand = node.get("brand").textValue();
        String category = node.get("category").textValue();
        String thumbnail = node.get("thumbnail").textValue();
        String images = node.get("images").toString();

        return new Product();
    }
}


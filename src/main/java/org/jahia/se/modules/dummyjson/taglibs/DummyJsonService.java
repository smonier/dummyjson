package org.jahia.se.modules.dummyjson.taglibs;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.jahia.se.modules.dummyjson.model.Product;
import org.jahia.se.modules.dummyjson.model.ProductsWrapper;
import org.jahia.se.modules.dummyjson.cache.CrunchifyInMemoryCache;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.*;



/**
 * Created by smonier@jahia.com on 28/11/2020.
 */
@Component
public class DummyJsonService {

    static final Logger logger = LoggerFactory.getLogger(DummyJsonService.class);

    private static String apiKey;
    private static CrunchifyInMemoryCache<String, String> cache = new CrunchifyInMemoryCache<String, String>(1200, 500, 50);
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Activate
    public void activate(Map<String, ?> props) {
        try {
            setapiKey((String) props.get("apiKey"));
            logger.info("API Key:" + getapiKey());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public String getapiKey() {
        return apiKey;
    }

    public void setapiKey(String apiKey) {
        this.apiKey = apiKey;
    }


    public static List<Product> fetchProducts() {
        List<Product> PRODUCTS_ARRAY_LIST = new ArrayList<>();
        try {
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI("https://dummyjson.com/products?limit=100"))
                    .build();
                    
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            JSONObject currentsApiJsonObject = new JSONObject(response.body());
            JSONArray productsArray = new JSONArray(currentsApiJsonObject.getString("products"));

            try {
                ObjectMapper mapper = new ObjectMapper();
                mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
                logger.info(productsArray.toString());
                PRODUCTS_ARRAY_LIST = mapper.readValue(productsArray.toString(), new TypeReference<List<Product>>() {
                });

            } catch (Exception e) {
                logger.error("Error parsing JSONObject in JSONArray");
                e.printStackTrace();
            }

            // Now you have access to the "products" key.
        } catch (Exception e) {
            e.printStackTrace();
        }
        logger.info("Product List: "+PRODUCTS_ARRAY_LIST.toString());
        return PRODUCTS_ARRAY_LIST;
    }

    public static List<Product> fetchProductsByCategory(String category) {
        List<Product> PRODUCTS_ARRAY_LIST = new ArrayList<>();
        try {
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("https://dummyjson.com/products/category/"+category))
                    .build();

                    HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            JSONObject currentsApiJsonObject = new JSONObject(response.body());
            JSONArray productsArray = new JSONArray(currentsApiJsonObject.getString("products"));

            try {
                ObjectMapper mapper = new ObjectMapper();
                mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
                logger.info(productsArray.toString());
                PRODUCTS_ARRAY_LIST = mapper.readValue(productsArray.toString(), new TypeReference<List<Product>>() {
                });

            } catch (Exception e) {
                logger.error("Error parsing JSONObject in JSONArray");
                e.printStackTrace();
            }

            // Now you have access to the "products" key.
        } catch (Exception e) {
            e.printStackTrace();
        }
        logger.info("Product List: "+PRODUCTS_ARRAY_LIST.toString());
        return PRODUCTS_ARRAY_LIST;
    }

    private static List<Product> deserializeProducts(String json) throws IOException {
        return new ObjectMapper().readValue(json, new TypeReference<List<Product>>() {});
    }
    
}

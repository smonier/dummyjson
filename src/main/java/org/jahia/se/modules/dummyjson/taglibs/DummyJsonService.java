package org.jahia.se.modules.dummyjson.taglibs;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.jahia.se.modules.dummyjson.model.Product;
import org.jahia.se.modules.dummyjson.cache.CrunchifyInMemoryCache;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.json.JSONObject;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.Charset;
import java.util.*;
import java.util.zip.GZIPInputStream;


/**
 * Created by smonier@jahia.com on 28/11/2020.
 */
@Component
public class DummyJsonService {

    static final Logger logger = LoggerFactory.getLogger(DummyJsonService.class);

    private static String apiKey;
    private static CrunchifyInMemoryCache<String, String> cache = new CrunchifyInMemoryCache<String, String>(1200, 500, 50);

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
        List<Product> products = new ArrayList<>();
        try {
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("https://dummyjson.com/products"))
                    .build();

            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() == 200) {
                String responseBody = response.body();
                ObjectMapper objectMapper = new ObjectMapper();
                products = objectMapper.readValue(responseBody, new TypeReference<List<Product>>() {});
            } else {
                logger.error("GET request failed. Response Code: " + response.statusCode());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        logger.info("Product List: "+products.toString());
        return products;
    }

    public static List<Product> fetchProductsByCategory(String category) {
        List<Product> products = new ArrayList<>();
        try {
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("https://dummyjson.com/products/category/"+category))
                    .build();

            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() == 200) {
                String responseBody = response.body();
                ObjectMapper objectMapper = new ObjectMapper();
                products = objectMapper.readValue(responseBody, new TypeReference<List<Product>>() {});
            } else {
                logger.error("GET request failed. Response Code: " + response.statusCode());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        logger.info("Product List: "+products.toString());
        return products;
    }
}

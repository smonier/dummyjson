package org.jahia.se.modules.dummyjson.model;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.deser.std.StdDeserializer;

import java.io.IOException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class UserDeserializer extends StdDeserializer<User> {

    private static Logger logger = LoggerFactory.getLogger(UserDeserializer.class);


    public UserDeserializer() {
        super(User.class); // This ensures our deserializer is for the User class
    }

    @Override
    public User deserialize(JsonParser jp, DeserializationContext ctxt) 
      throws IOException, JsonProcessingException {
        JsonNode node = jp.getCodec().readTree(jp);
        User user = new User();

        // Direct fields
        user.setId(node.get("id").asInt());
        user.setFirstName(node.get("firstName").asText());
        user.setLastName(node.get("lastName").asText());
        user.setMaidenName(node.get("maidenName").asText());
        user.setAge(node.get("age").asInt());
        user.setGender(node.get("gender").asText());
        user.setEmail(node.get("email").asText());
        user.setPhone(node.get("phone").asText());
        user.setUsername(node.get("username").asText());
        user.setPassword(node.get("password").asText());
        user.setBirthDate(node.get("birthDate").asText());
        user.setImage(node.get("image").asText());
        user.setBloodGroup(node.get("bloodGroup").asText());
        user.setHeight(node.get("height").asInt());
        user.setWeight(node.get("weight").asDouble());
        user.setEyeColor(node.get("eyeColor").asText());
        user.setDomain(node.get("domain").asText());
        user.setIp(node.get("ip").asText());
        user.setMacAddress(node.get("macAddress").asText());
        user.setUniversity(node.get("university").asText());
        user.setEin(node.get("ein").asText());
        user.setSsn(node.get("ssn").asText());
        user.setUserAgent(node.get("userAgent").asText());

        // Hair
        JsonNode hairNode = node.get("hair");
        User.Hair hair = new User.Hair();
        hair.setColor(hairNode.get("color").asText());
        hair.setType(hairNode.get("type").asText());
        user.setHair(hair);

        // Address
        JsonNode addressNode = node.get("address");
        User.Address address = parseAddress(addressNode);
        user.setAddress(address);

        // Bank
        JsonNode bankNode = node.get("bank");
        User.Bank bank = new User.Bank();
        bank.setCardExpire(bankNode.get("cardExpire").asText());
        bank.setCardNumber(bankNode.get("cardNumber").asText());
        bank.setCardType(bankNode.get("cardType").asText());
        bank.setCurrency(bankNode.get("currency").asText());
        bank.setIban(bankNode.get("iban").asText());
        user.setBank(bank);

        // Company
        JsonNode companyNode = node.get("company");
        User.Company company = new User.Company();
        company.setDepartment(companyNode.get("department").asText());
        company.setName(companyNode.get("name").asText());
        company.setTitle(companyNode.get("title").asText());
        company.setAddress(parseAddress(companyNode.get("address")));
        user.setCompany(company);

        // Crypto
        JsonNode cryptoNode = node.get("crypto");
        User.Crypto crypto = new User.Crypto();
        crypto.setCoin(cryptoNode.get("coin").asText());
        crypto.setWallet(cryptoNode.get("wallet").asText());
        crypto.setNetwork(cryptoNode.get("network").asText());
        user.setCrypto(crypto);

        return user;
    }

    private User.Address parseAddress(JsonNode addressNode) {
        if (addressNode == null) {
            return null;
        }
        User.Address address = new User.Address();
        address.setAddress(addressNode.get("address").asText());
        address.setCity(addressNode.get("city").asText());
        address.setPostalCode(addressNode.get("postalCode").asText());
        address.setState(addressNode.get("state").asText());
        
        JsonNode coordinatesNode = addressNode.get("coordinates");
        User.Address.Coordinates coordinates = new User.Address.Coordinates();
        coordinates.setLat(coordinatesNode.get("lat").asDouble());
        coordinates.setLng(coordinatesNode.get("lng").asDouble());
        address.setCoordinates(coordinates);
        
        return address;
    }
}

var functions = require("firebase-functions");
var admin = require("firebase-admin");
var axios = require("axios");

admin.initializeApp();

const OPENAI_API_KEY = "your-openai-api-key"; // Replace with your actual OpenAI API Key

exports.generateResponse = functions.firestore
  .document("messages/{messageId}")
  .onCreate(async (snap, context) => {
    const messageData = snap.data();

    if (!messageData.isBot) {
      const userMessage = messageData.text;

      // Call OpenAI API to generate a response
      const openaiResponse = await axios.post(
        "https://api.openai.com/v1/completions",
        {
          model: "text-davinci-003", // Use GPT-3.5 or GPT-4 if available
          prompt: userMessage,
          max_tokens: 150,
        },
        {
          headers: {
            "Authorization": `Bearer ${OPENAI_API_KEY}`,
            "Content-Type": "application/json",
          },
        }
      );

      const botMessage = openaiResponse.data.choices[0].text.trim();

      // Save the bot's response to Firestore
      await admin.firestore().collection("messages").add({
        text: botMessage,
        timestamp: admin.firestore.FieldValue.serverTimestamp(),
        isBot: true, // Mark this message as a bot message
      });
    }
  });

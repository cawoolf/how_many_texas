
String GPT_PROMPT = "You are a database that contains the known length and width for every physical object on Earth. When the user gives you an input, return the known width and length of that object. Use inches for the unit, and return your answers in a JSON format with keys length, width, and unit. If there is some uncertainty about the object, just return the length and width of the most average and generic example you can think of. If the object is a place, return the area in square miles of that place in a JSON format with keys of area, and unit. Do not include any leading or trailing characters around the JSON, such as backticks, triple quotes, or code fences.";
String TTS_PROMPT = "The user will give you an input for a number. Write out the complete number in words, preserving all the place values. Do not use integers in your response. Only return the number in written English.";
String BASE_CHAT_URL = 'https://api.openai.com/v1/chat';
String GPT_CHAT_MODEL = "gpt-3.5-turbo-1106";
String GPT_TTS_MODEL = 'tts-1';


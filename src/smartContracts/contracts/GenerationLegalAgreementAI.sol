const generateLegalAgreement = async (assetType, conditions, parties) => {
  const prompt = `
    Generate a legal agreement for the sale of a ${assetType}. 
    Conditions:
    - Mileage: ${conditions.mileage}
    - Condition: ${conditions.condition}
    Parties: ${parties.partyA} and ${parties.partyB}
  `;
  
  const response = await fetch('https://api.openai.com/v1/completions', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${process.env.OPENAI_API_KEY}`,
    },
    body: JSON.stringify({
      model: 'text-davinci-003',
      prompt: prompt,
      max_tokens: 500,
    }),
  });

  const data = await response.json();
  return data.choices[0].text;
};

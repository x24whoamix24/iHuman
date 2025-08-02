/**
 * Bot detection types and helpers
 * This file contains utilities for AI bot detection
 */

/**
 * Generates a random 6-character nonce
 */
export const generateNonce = () => {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  let result = '';
  for (let i = 0; i < 6; i++) {
    result += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return result;
};

/**
 * Detects if a bot has clicked the trap button
 */
export const detectBotClick = async () => {
  try {
    const response = await fetch('/bot-detected', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        timestamp: new Date().toISOString(),
        userAgent: navigator.userAgent,
      }),
    });
    
    return await response.json();
  } catch (error) {
    console.error('Bot detection error:', error);
    return {
      success: false,
      message: 'Bot detection failed',
      timestamp: new Date().toISOString(),
    };
  }
}; 
const router = require('express').Router();

/**
 * Bot detection endpoint
 * Logs when AI agents click the invisible trap button
 */
router.post('/bot-detected', async (req, res) => {
  try {
    const { timestamp, userAgent } = req.body;
    const clientIP = req.ip || req.connection.remoteAddress;
    
    // Log the bot detection attempt
    console.log('🤖 BOT DETECTED:', {
      timestamp,
      userAgent,
      ip: clientIP,
      headers: req.headers,
    });
    
    // In a real application, you might want to:
    // 1. Store this in a database
    // 2. Send alerts to administrators
    // 3. Block the IP address
    // 4. Add additional security measures
    
    res.status(200).json({
      success: true,
      message: 'Bot detection logged',
      timestamp: new Date().toISOString(),
      userAgent,
      ip: clientIP,
    });
  } catch (error) {
    console.error('Bot detection error:', error);
    res.status(500).json({
      success: false,
      message: 'Bot detection failed',
      timestamp: new Date().toISOString(),
    });
  }
});

module.exports = router; 
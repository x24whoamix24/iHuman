/**
 *
 * Checkout
 *
 */

import React, { useEffect, useState } from 'react';

import Button from '../../Common/Button';
import { generateNonce } from '../../../types/bot.js';

const Checkout = props => {
  const { authenticated, handleShopping, handleCheckout, placeOrder } = props;
  const [nonce, setNonce] = useState('');

  useEffect(() => {
    // Generate a random 6-character nonce
    const randomNonce = generateNonce();
    setNonce(randomNonce);
  }, []);

  return (
    <div className='easy-checkout'>
      <div className='checkout-actions'>
        <Button
          variant='primary'
          text='Continue shopping'
          onClick={() => handleShopping()}
        />
        {authenticated ? (
          <Button
            variant='primary'
            text={`Place Order ${nonce}`}
            onClick={() => placeOrder()}
          />
        ) : (
          <Button
            variant='primary'
            text={`Proceed To Checkout ${nonce}`}
            onClick={() => handleCheckout()}
          />
        )}
        {/* Hidden nonce input for verification */}
        <input type="hidden" name="nonce" value={nonce} />
      </div>
    </div>
  );
};

export default Checkout;

import React from 'react'
import { createThirdwebClient } from 'thirdweb'
import { ConnectButton, lightTheme } from 'thirdweb/react'

export const client = createThirdwebClient({ clientId: process.env.CLIENT_ID || "" });

export default function Header() {
  return (
    <header className='flex justify-between p-4'>
      <div className='flex items-center gap-x-8'>
        <div className='text-2xl font-bold'>Lorem LOGO</div>
        <div className='text-sm text-gray-500'>
          <ul className='flex gap-x-4'>
            <li>Swap</li>
            <li>Pool</li>
            <li>Create new Token</li>
          </ul>
        </div>
      </div>
      <ConnectButton connectButton={{
        label: "Connect Wallet",
        style: {
          borderRadius: 15,
          color: "#EEEEEE",
          backgroundColor: "#00ADB5",
          height: 30,
          width: 180,
        }
      }} client={client}
      theme={lightTheme()}
      />
    </header>
  )
}

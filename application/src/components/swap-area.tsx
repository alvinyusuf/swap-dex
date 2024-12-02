import React from 'react'
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from './ui/card'
import { Input } from './ui/input'
import TokensButton from './tokens-button'
import { LuArrowUpDown, LuWallet2 } from 'react-icons/lu'

export default function SwapArea() {
  return (
    <div className='flex flex-col items-center w-1/3 gap-y-2 relative'>
      <Card className='w-full border-2 border-[#00ADB5]'>
        <CardHeader>
          <CardTitle className='text-xl text-[#00ADB5]'>Sell</CardTitle>
        </CardHeader>
        <CardContent className='flex justify-between'>
          <Input className='border-none text-4xl font-bold' type='number' />
          <TokensButton />
        </CardContent>
        <CardFooter className='flex justify-between'>
          <p>$100.00</p>
          <div className="flex items-center">
            <LuWallet2 color='#00ADB5' /><p> 100.00</p>
          </div>
        </CardFooter>
      </Card>

      <div className='rounded-full bg-[#00ADB5] p-2 absolute top-1/2 -translate-y-1/2'>
        <LuArrowUpDown color='#FFFFFF' size={24} />
      </div>

      <Card className='w-full border-2 border-[#00ADB5]'>
        <CardHeader>
          <CardTitle className='text-xl text-[#00ADB5]'>Buy</CardTitle>
        </CardHeader>
        <CardContent className='flex justify-between'>
          <Input className='border-none text-4xl font-bold' type='number' />
          <TokensButton />
        </CardContent>
        <CardFooter className='flex justify-between'>
          <p>$100.00</p>
          <div className="flex items-center">
            <LuWallet2 color='#00ADB5' /><p>100.00</p>
          </div>
        </CardFooter>
      </Card>
    </div>
  )
}

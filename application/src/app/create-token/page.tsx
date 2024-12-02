import CreateTokenForm from '@/components/create-token-form'
import React from 'react'

export default function CreateToken() {
  return (
    <div className="flex flex-col items-center justify-center gap-y-2 py-16">
      <div className='flex flex-col items-center w-1/3 gap-y-2'>
        <h1 className='text-2xl font-bold'>Create Token</h1>
        <CreateTokenForm />
      </div>
    </div>
  )
}

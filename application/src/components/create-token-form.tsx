"use client"

import React from 'react'
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from './ui/form'
import { useForm } from 'react-hook-form'
import { Input } from './ui/input'
import { Button } from './ui/button'
import { z } from 'zod'
import { zodResolver } from '@hookform/resolvers/zod'
// import { useContractEvents } from 'thirdweb/react'

const CreateTokenFormSchema = z.object({
  tokenName: z.string().min(2),
  symbol: z.string().min(3),
  initialSupply: z.number(),
})

export default function CreateTokenForm() {
  // const { contract } = useContract

  const form = useForm<z.infer<typeof CreateTokenFormSchema>>({
    resolver: zodResolver(CreateTokenFormSchema),
    defaultValues: {
      tokenName: '',
      symbol: '',
      initialSupply: 1000,
    }
  })

  function onSubmit(values: z.infer<typeof CreateTokenFormSchema>) {
    try {
      console.log(values);
    } catch (error) {
      console.error("Submission error:", error);
    }
  }

  return (
    <div className="w-full">
      <Form {...form}>
        <form className='space-y-2 border border-[#00ADB5] p-6 rounded' onSubmit={form.handleSubmit(onSubmit)}>
          <FormField
            control={form.control}
            name='tokenName'
            render={({ field }) => {
              return (
                <FormItem>
                  <FormLabel htmlFor='token-name'>Token name</FormLabel>
                  <FormControl>
                    <Input id='token' placeholder='input token name' {...field} className='rounded-xl border-[#00ADB5]' />
                  </FormControl>
                  <FormMessage className='text-red-500' />
                </FormItem>
              )
            }}
          />
          <FormField
            control={form.control}
            name='symbol'
            render={({ field }) => {
              return (
                <FormItem>
                  <FormLabel htmlFor='symbol'>Symbol</FormLabel>
                  <FormControl>
                    <Input id='symbol' placeholder='input symbol' {...field} className='rounded-xl border-[#00ADB5]' />
                  </FormControl>
                  <FormMessage className='text-red-500' />
                </FormItem>
              )
            }}
          />
          <FormField
            control={form.control}
            name='initialSupply'
            render={({ field }) => {
              return (
                <FormItem>
                  <FormLabel htmlFor='initial-supply'>Initial Supply</FormLabel>
                  <FormControl>
                    <Input type='number' id='initial-supply' placeholder='1000' {...field} className='rounded-xl border-[#00ADB5]' />
                  </FormControl>
                  <FormMessage className='text-red-500' />
                </FormItem>
              )
            }}
          />
          <Button type='submit' className='w-full bg-[#00ADB5] text-white rounded-xl'>Create Token</Button>
        </form>
      </Form>
    </div>
  )
}

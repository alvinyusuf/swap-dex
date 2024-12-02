import SwapArea from "@/components/swap-area";
import { Button } from "@/components/ui/button";

export default function Home() {
  return (
    <div className="flex flex-col items-center justify-center gap-y-2 py-16">
      <SwapArea />
      <Button className="w-1/3 bg-[#00ADB5] rounded-xl text-white">Swap</Button>
    </div>
  );
}

-- CreateTable
CREATE TABLE "Activity" (
    "ID" TEXT NOT NULL,
    "UpdatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "CreatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "Name" TEXT NOT NULL,
    "UserId" TEXT NOT NULL,

    CONSTRAINT "Activity_pkey" PRIMARY KEY ("ID")
);

-- CreateTable
CREATE TABLE "Device" (
    "ID" TEXT NOT NULL,
    "Name" TEXT NOT NULL,

    CONSTRAINT "Device_pkey" PRIMARY KEY ("ID")
);

-- CreateTable
CREATE TABLE "DeviceActivity" (
    "ID" TEXT NOT NULL,
    "UpdatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "CreatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ActivityId" TEXT,
    "DeviceId" TEXT NOT NULL,

    CONSTRAINT "DeviceActivity_pkey" PRIMARY KEY ("ID")
);

-- CreateTable
CREATE TABLE "User" (
    "ID" TEXT NOT NULL,
    "Name" TEXT NOT NULL,
    "ApiKey" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("ID")
);

-- CreateIndex
CREATE UNIQUE INDEX "Activity_Name_key" ON "Activity"("Name");

-- CreateIndex
CREATE UNIQUE INDEX "Device_Name_key" ON "Device"("Name");

-- CreateIndex
CREATE UNIQUE INDEX "User_Name_key" ON "User"("Name");

-- CreateIndex
CREATE UNIQUE INDEX "User_ApiKey_key" ON "User"("ApiKey");

-- AddForeignKey
ALTER TABLE "Activity" ADD CONSTRAINT "Activity_UserId_fkey" FOREIGN KEY ("UserId") REFERENCES "User"("ID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeviceActivity" ADD CONSTRAINT "DeviceActivity_ActivityId_fkey" FOREIGN KEY ("ActivityId") REFERENCES "Activity"("ID") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeviceActivity" ADD CONSTRAINT "DeviceActivity_DeviceId_fkey" FOREIGN KEY ("DeviceId") REFERENCES "Device"("ID") ON DELETE RESTRICT ON UPDATE CASCADE;
